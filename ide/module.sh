source $PWD/__setup/util.sh

OS=`cat $CMD_FILE`

_pre_arch(){

	printSubsection "instala os pacotes necessários para a distro arch linux, módulo ide"

	# meld é uma aplicação estilo winmerge
	sudo pacman -Sy vim-gtk docker meld

	bkp=$PWD

	# instalando vscode
	printSubSubsection "Installing VSCode"
	git clone https://aur.archlinux.org/visual-studio-code-bin.git $HOME/.aur/visual-studio-code-bin
       	cd $HOME/.aur/visual-studio-code-bin
	makepkg -si --needed	
	cd $bkp

	printOK

}

_pre_ubuntu(){

	printSubsection "instala os pacotes necessários para a distro ubuntu, módulo ide"

	# meld é uma aplicação estilo winmerge
	sudo apt install jq software-properties-common apt-transport-https wget vim-gtk exuberant-ctags meld -y

	# instalando vscode
	#printSubSubsection "Installing VSCode"
	#wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
	#sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
	#sudo apt-get update
	#sudo apt install code

	printSubSubsection "Installing Docker"
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    echo \
      "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt update
    sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

	sudo groupadd docker 2> /dev/null
	sudo usermod -aG docker $USER

    # ainda não podemos rodar o docker sem ser sudo, porque o PC não foi reinicializado...
    sudo docker run hello-world

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
	stowit $PWD/ide/base

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

	printSubsection "git configs"
	git config --global core.excludesfile '~/.gitignore_global'
	git config --global init.templatedir '~/.git-templates'

	touch $DOT_FOLDER/ide.lock
	printOK

    fi

}

uninstall(){
    echo "Not implemented yet"
}
