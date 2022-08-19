source $PWD/__setup/util.sh

install(){

    printSection "POLYBAR"

    if ! which polybar &> /dev/null; then
        echo "Polybar not installed. Please install to continue"
        return
    fi

    stowit $PWD/polybar/base

    printOK

}

uninstall(){
    echo "To be implemented"
}
