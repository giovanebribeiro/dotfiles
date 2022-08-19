source $PWD/__setup/util.sh

install(){

    printSection "MARKDOWN"
    
    if [ ! -d $HOME/bin ]; then
        mkdir $HOME/bin
    fi
    wget -O $HOME/bin/mdr https://github.com/MichaelMure/mdr/releases/download/v0.2.2/mdr_linux_amd64
    chmod +x $HOME/bin/mdr

    printOK

}

uninstall(){
    echo "To be implemented"
}
