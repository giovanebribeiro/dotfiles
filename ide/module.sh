source $PWD/__setup/util.sh

OS=`cat $CMD_FILE`

_pre_arch(){

	printSubsection "instala os pacotes necessários para a distro arch linux, módulo ide"

	sudo pacman -Sy vim-gtk docker exuberant-ctags

	bkp=$PWD

	# instalando vscode
	printSubSubsection "Installing VSCode"
	git clone https://aur.archlinux.org/visual-studio-code-bin.git $HOME/.aur/visual-studio-code-bin
       	cd $HOME/.aur/visual-studio-code-bin
	makepkg -si --needed	
	cd $bkp

	printOK

}

install(){
    
	
    if [ ! -f $DOT_FOLDER/ide.lock ]; then

	printSection "IDE"

	if [ ! -f $DOT_FOLDER/ide.lock_module ]; then
		_pre_$OS 
		touch $DOT_FOLDER/ide.lock_module
	fi

	printSubsection "VIM configurations"

	# copiando .vimrc
	stowit $PWD/base

	if [ ! -d $HOME/.vim/bundle ]; then
		printSubSubsection "Installing VIM plugins"
		mkdir -p $HOME/.vim/bundle
		git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
		vim +PluginInstall +qall
	else
		printSubSubsection "Updating VIM plugins"
		vim +PluginUpdate +qall
	fi
    
	[ ! -d $HOME/.vim/sessions ] && mkdir -p $HOME/.vim/sessions

	printSubsection "Aliasing some docker commands"

	aliasit "mysql_start" "'docker run -d -p 3306:3306 --name db_mysql -e MYSQL_ROOT_PASSWORD=root mysql'"
	aliasit "mysql_stop" "'docker stop db_mysql && docker rm db_mysql'"
	aliasit "docker_clean" "'docker image prune -a && docker container prune && docker volume prune && docker network prune'"

	printSubsection "CTAGS configurations"
	stowit $PWD/ctags/base

	touch $DOT_FOLDER/ide.lock
	printOK

    fi

}

uninstall(){
    echo "Not implemented yet"
}
