source $PWD/__setup/util.sh

install(){

    printSection "GIT CONFIGURATIONS"

    stowit $PWD/git/base
    git config --global core.excludesfile $HOME/.gitignore_global

    printOK

}

uninstall(){
    echo "To be implemented"
}
