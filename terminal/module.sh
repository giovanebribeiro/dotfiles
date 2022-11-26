source $PWD/__setup/util.sh

OS=`cat $CMD_FILE`

_pre_arch(){
    printSection "instala os pacotes necessários para a distro arch linux, módulo terminal"

    sudo pacman -Sy zsh alacritty powerline

    printOK
    
}

_pre_ubuntu(){
    printSection "instala os pacotes necessários para a distro ubuntu, módulo terminal"

    sudo apt-get install alacritty tmux

    printOK
    
}

install(){


	if [ ! -f $DOT_FOLDER/terminal.lock ]; then

		if [ ! -f $DOT_FOLDER/terminal.lock_module ]; then
			_pre_$OS 
    
			printSection "instala oh-my-zsh"
			sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
			printOK

			touch $DOT_FOLDER/terminal.lock_module
		fi
		
		printSubsection "Installing typewritten theme for zsh"
		git clone https://github.com/reobin/typewritten.git $ZSH/themes/typewritten
		ln -s "$ZSH/themes/typewritten/typewritten.zsh-theme" "$ZSH/themes/typewritten.zsh-theme"

		if [ "$OS" = "darwin" ]; then
			aliasit "ls" "'ls -G'"
    			aliasit "showFiles" "'defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'"
    			aliasit "hideFiles" "'defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'"
		else
		    aliasit "ls" "'ls --color=auto'"
		fi
    
		stowit $PWD/terminal/base

		printSection "Configuring TMUX"

		if [ ! -d $HOME/.tmux ]; then
			git clone https://github.com/gpakosz/.tmux $HOME/.tmux
		else
			tmp=$PWD
			cd $HOME/.tmux
			git pull
			cd $tmp
		fi

		stowit $PWD/terminal/tmux/base
		[ -r $HOME/.tmux.conf ] && rm $HOME/.tmux.conf
		ln -sv $HOME/.tmux/.tmux.conf $HOME/.tmux.conf

		printOK

		printOK

	fi


    #rm $HOME/bin/change_volume
    #ln -s $PWD/base/change_volume.sh $HOME/bin/change_volume
    #source $HOME/.zshrc

    #printSubsection "Installing aliases..."
    #if [ "$OS" = "Darwin" ]; then
    
    #elif [ "$OS" = "Linux" ]; then
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
