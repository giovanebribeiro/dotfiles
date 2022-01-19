source $PWD/__setup/util.sh
OS=`uname`

install(){

    printSection "BASIC INSTALLATIONS (ZSH, ALIASES AND EXPORTS)"

    # installing zsh
    installPkg "zsh"

    if [ "$SHELL" -ne "/usr/bin/zsh" ]; then
        sudo chsh -s /usr/bin/zsh $USER
    fi
    
    if [ ! -d $HOME/.oh-my-zsh ]; then
	    echo "You not install oh-my-zsh. Please install it:"
	    echo '$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"'
	    exit 0
    fi
    
    # We must do this again because oh-my-zsh overwrites our zshrc.
    if [ -f "$HOME/.zshrc" ]; then
        rm $HOME/.zshrc
    fi

    stowit $PWD/base/base
    source $HOME/.zshrc

    if [ ! -d "$ZSH_CUSTOM/themes/typewritten" ]; then
        printSubsection "Installing typewritten theme for zsh"
        git clone https://github.com/reobin/typewritten.git $ZSH/themes/typewritten
        ln -s "$ZSH/themes/typewritten/typewritten.zsh-theme" "$ZSH/themes/typewritten.zsh-theme"
    fi

    printSubsection "Installing aliases..."
    if [ "$OS" = "Darwin" ]; then
        aliasit "ls" "'ls -G'"
        aliasit "showFiles" "'defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'"
        aliasit "hideFiles" "'defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'"
    elif [ "$OS" = "Linux" ]; then
        aliasit "ls" "'ls --color=auto'"
    fi

    printSubsection "Installing exports..."

    if [ "$OS" = "Darwin" ]; then
        exportit "CLICOLOR" "'true'"
        exportit "LSCOLORS" "gxfxcxdxbxCgCdabagacad"
    fi

    printOK
    
}

uninstall(){
    echo "To be implemented"
}
