source $PWD/__setup/util.sh

install(){
    printSection "ROFI (application manager)"

    # install rofi
    installPkg rofi

    # install dependencies for aux scripts
    installPkg scrot
    installPkg gimp

    stowit $PWD/rofi/base
}

uninstall(){
    echo "To be implemented"
}
