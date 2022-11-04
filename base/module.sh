source $PWD/__setup/util.sh

OS=`cat $CMD_FILE`

_pre_arch(){

	printSubsection "instala os pacotes necessários para a distro arch linux, módulo base"

	sudo pacman -Sy stow curl wget

	printOK

}

install(){
	
	if [ ! -f $DOT_FOLDER/base.lock ]; then

		printSection "BASIC INSTALLATIONS"

		if [ ! -f $DOT_FOLDER/base.lock_module ]; then
			_pre_$OS 
			touch $DOT_FOLDER/base.lock_module
		fi

		if [ "$OS" = "arch" ]; then

			# criando a pasta do aur, caso não exista
			mkdir -p $HOME/.aur 2>/dev/null

			# criando link para o arquivo aur_update
			rm $HOME/.aur/aur-update.sh 2>/dev/null
			ln -s $PWD/base/aur-update.sh $HOME/.aur/aur-update.sh

		fi

		touch $DOT_FOLDER/base.lock
		printOK
		
	fi

}

uninstall(){
    echo "To be implemented"
}
