source $PWD/__setup/util.sh

install(){

    echo "To be implemented"
    printSection "BSPWM INSTALLS AND CONFIGURATIONS"

    stowit $PWD/git/base
    git config --global core.excludesfile $HOME/.gitignore_global

    printOK

}

uninstall(){
    echo "To be implemented"
}
