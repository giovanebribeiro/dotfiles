source $PWD/__setup/util.sh

install(){
    printSection "RUST"
    
    if [ ! -d $HOME/.cargo ]; then
        printSubsection "Installing rustup"
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        exportit "PATH" "$HOME/.cargo/bin:$PATH"
        source $HOME/.cargo/env
    else
        rustup update
    fi
    
    if [ ! -f $HOME/.cargo/bin/what ]; then
        printSubSubsection "Install what (network packet sniffer)"
        cargo install what
        sudo ln -s $HOME/.cargo/bin/what /usr/local/bin/what
    else
        printSubSubsection "what already installed"
    fi

    if [ ! -f $HOME/cargo/bin/ytop ]; then
        printSubSubsection "Install ytop (system monitor)"
        cargo install -f --git https://github.com/cjbassi/ytop ytop
        aliasit "oldtop" "/usr/bin/top"
        aliasit "top" "'ytop --minimal'"
        aliasit "topster" "ytop"
    fi

    printOK

}

uninstall(){
}

