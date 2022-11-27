source $PWD/__setup/util.sh

OS=`cat $CMD_FILE`

_pre_arch(){
    printSection "instala os pacotes necessários para a distro arch linux, módulo terminal"

    sudo pacman -Sy zsh alacritty powerline

    printOK
    
}

_pre_ubuntu(){
    printSection "instala os pacotes necessários para a distro ubuntu, módulo terminal"

    sudo apt-get install tmux

    printSubsection "instalando alacritty (terminal emulator)"
    
    sudo apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

    printSubsection "Installing rustup"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/env

    git clone https://github.com/alacritty/alacritty.git $BIN_FOLDER/alacritty
    TEMP=$PWD
    cd $BIN_FOLDER/alacritty
    cargo build --release

    # post build (terminfo, desktop entry, etc)
    sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
    sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
    sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
    sudo desktop-file-install extra/linux/Alacritty.desktop
    sudo update-desktop-database

    cd $TEMP

    printOK
    
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
		
		# removendo o zshrc padrão para inclusão do nosso zshrc
		rm $HOME/.zshrc

		if [ "$OS" = "darwin" ]; then
			aliasit "ls" "'ls -G'"
			aliasit "showFiles" "'defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'"
			aliasit "hideFiles" "'defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'"

			exportit "CLICOLOR" "'true'"
			exportit "LSCOLORS" "gxfxcxdxbxCgCdabagacad"
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

		stowit $PWD/terminal/tmux.base
		[ -r $HOME/.tmux.conf ] && rm $HOME/.tmux.conf
		ln -sv $HOME/.tmux/.tmux.conf $HOME/.tmux.conf

		printOK

		printOK
		touch $DOT_FOLDER/terminal.lock

		source $HOME/.zshrc

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
    #fi

    #printOK
    
}

uninstall(){
    echo "To be implemented"
}
