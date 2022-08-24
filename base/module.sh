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
		fi

		touch $DOT_FOLDER/base.lock
	
		printOK
		
	fi

}

uninstall(){
    echo "To be implemented"
}
