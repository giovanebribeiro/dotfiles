source $PWD/__setup/util.sh

OS=`cat $CMD_FILE`

_pre_arch(){
    printSection "instala os pacotes necessários para a distro arch linux, módulo terminal"

    sudo pacman -Sy zsh alacritty powerline

    printOK
    
}

_pre_ubuntu(){
    printSection "instala os pacotes necessários para a distro arch linux, módulo terminal"

    sudo apt-get install zsh alacritty powerline

    printOK
    
}

install(){


	if [ ! -f $DOT_FOLDER/terminal.lock ]; then

		if [ ! -f $DOT_FOLDER/base.lock_module ]; then
			_pre_$OS 
			touch $DOT_FOLDER/base.lock_module
		fi
		
		curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh

		printSubsection "Installing typewritten theme for zsh"
		git clone https://github.com/reobin/typewritten.git $ZSH/themes/typewritten
		ln -s "$ZSH/themes/typewritten/typewritten.zsh-theme" "$ZSH/themes/typewritten.zsh-theme"
    
		stowit $PWD/base

		printOK

	fi


    #rm $HOME/bin/change_volume
    #ln -s $PWD/base/change_volume.sh $HOME/bin/change_volume
    #source $HOME/.zshrc

    #printSubsection "Installing aliases..."
    #if [ "$OS" = "Darwin" ]; then
    #    aliasit "ls" "'ls -G'"
    #    aliasit "showFiles" "'defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'"
    #    aliasit "hideFiles" "'defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'"
    #elif [ "$OS" = "Linux" ]; then
    #    aliasit "ls" "'ls --color=auto'"
    #fi

    #printSubsection "Installing exports..."

    #if [ "$OS" = "Darwin" ]; then
    #    exportit "CLICOLOR" "'true'"
    #    exportit "LSCOLORS" "gxfxcxdxbxCgCdabagacad"
    #fi

    #printOK
    
}

uninstall(){
    echo "To be implemented"
}
