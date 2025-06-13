source $PWD/__setup/util.sh

OS=`cat $CMD_FILE`

_pre_arch(){

	printSubsection "instala os pacotes necessários para a distro arch linux, módulo base"

	sudo pacman -Sy stow curl wget

	printOK

}

_pre_ubuntu(){

	printSubsection "instala os pacotes necessários para a distro ubuntu, módulo base"

    sudo apt update
    sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev
    sudo apt install -y llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
    sudo apt install -y wget curl llvm python-dev python3-dev stow x11-server-utils
    sudo apt install -y ca-certificates gnupg

    printSubsection "Colocando zsh como shell padrão (vai precisar reiniciar o computador)"
    sudo apt install zsh
    sudo chsh -s $(which zsh)

    printOK

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

		mkdir -p $BIN_FOLDER

		touch $DOT_FOLDER/base.lock
		printOK
		
	fi

}

uninstall(){
    echo "To be implemented"
}
