source $PWD/__setup/util.sh
INSTALL=$(cat $CMD_FILE)

install(){
    
    printSection "VIM"

    if which vim.gtk &> /dev/null; then
        printSubSubsection "VIM already installed"
    else
        OS=`uname`
        case $OS in 
          "Darwin")
            $INSTALL macvim
            ;;
          "Linux")
            $INSTALL vim
            ;;
          "*")
            printError "Unknown OS"
            ;;
        esac
        printSubSubsection "VIM installed successfully"
    fi

    stowit $PWD/vim/base

    if [ ! -d $HOME/.vim/bundle ]; then
        printSubSubsection "Installing plugins"
        mkdir -p $HOME/.vim/bundle
        git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
        vim +PluginInstall +qall
    else
        printSubSubsection "Updating plugins"
        vim +PluginUpdate +qall
    fi

    printSubSubsection "Action needed for YouCompleteMe plugin"
    python3 $HOME/.vim/bundle/YouCompleteMe/install.py --ts-completer --rust-completer --java-completer

    [ ! -d $HOME/.vim/sessions ] && mkdir -p $HOME/.vim/sessions

    printOK

}

uninstall(){
    echo "Not implemented yet"
}
