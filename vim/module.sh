source $PWD/__setup/util.sh

install(){
    
    printSection "VIM"

    if which vim.gtk &> /dev/null; then
        printSubSubsection "VIM already installed"
    else
        OS=`uname`
        case $OS in 
          "Darwin")
            installPkg macvim
            ;;
          "Linux")
            installPkg vim
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

    [ ! -d $HOME/.vim/sessions ] && mkdir -p $HOME/.vim/sessions

    printOK

}

uninstall(){
    echo "Not implemented yet"
}
