source $PWD/__setup/util.sh

install(){

    printSection "CTAGS"

    installPkg exuberant-ctags
    stowit $PWD/ctags/base

    printOK

}

uninstall(){
    echo "To be implemented"
}
