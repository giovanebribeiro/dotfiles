source $PWD/__setup/util.sh
OS=`uname`

install(){

    printSection "ZSH"

    if [ "$OS" == "Linux" ]; then
        if [ ! -f ~/.local/share/fonts/PowerlineSymbols.otf ]; then
            printSubsection "Installing Powerline fonts"
            wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
            mv PowerlineSymbols.otf ~/.local/share/fonts/
            fc-cache -vf ~/.local/share/fonts/
            printSubsection "Installing Powerline fonts... OK (Please go to your terminal configurations and select the powerline fonts there)"
        fi
        
        installPkg zsh
    fi

    installPkg neofetch cmatrix

    if [ "$SHELL" -ne "/usr/bin/zsh" ];then
        sudo chsh -s /usr/bin/zsh $USER
    fi
    
    printSubsection "Installing oh-my-zsh"
    [ ! -d $HOME/.oh-my-zsh ] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"
    
    # We must do this again because oh-my-zsh overwrites our zshrc.
    if [ -f "$HOME/.zshrc" ]; then
        rm $HOME/.zshrc
    fi

    stowit $PWD/zsh/base
    source $HOME/.zshrc

    if [ ! -d "$ZSH_CUSTOM/themes/typewritten" ]; then
        printSubsection "Installing typewritten theme for zsh"
        git clone https://github.com/reobin/typewritten.git $ZSH_CUSTOM/themes/typewritten
        ln -s "$ZSH_CUSTOM/themes/typewritten/typewritten.zsh-theme" "$ZSH_CUSTOM/themes/typewritten.zsh-theme"
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
