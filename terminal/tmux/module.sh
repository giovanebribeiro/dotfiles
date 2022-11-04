source $PWD/__setup/util.sh

install(){
    
    printSection "TMUX"

    installPkg tmux
    if [ ! -d $HOME/.tmux ]; then
        git clone https://github.com/gpakosz/.tmux $HOME/.tmux
    else
        tmp=$PWD
        cd $HOME/.tmux
        git pull
        cd $tmp
    fi

    stowit $PWD/tmux/base
    [ -r $HOME/.tmux.conf ] && rm $HOME/.tmux.conf
    ln -sv $HOME/.tmux/.tmux.conf $HOME/.tmux.conf

    printOK

}

uninstall(){
    echo "To be implemented"
}

