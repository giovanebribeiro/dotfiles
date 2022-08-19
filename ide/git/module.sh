source $PWD/__setup/util.sh

install(){

    printSection "GIT CONFIGURATIONS"

    stowit $PWD/git/base
    git config --global core.excludesfile '~/.gitignore_global'
    git config --global init.templatedir '~/.git-templates'


    printOK

}

uninstall(){
    echo "To be implemented"
}
