LOG_FILE=$HOME/dotfiles.log
LOC_FILE=$HOME/.dotfiles-loc

OS=`uname`
INSTALL=$INSTALL_CMD

function printSection() { echo "# $1"; echo;  }
function printSubsection() { echo; echo "- $1"; echo;}
function printSubSubsection() { echo "* $1"; }
function printError() { echo "x $1"; }
function printOK() { echo; echo "...OK"; echo; }

installPkg() {
    TEMP=()
    for pkg in "$@"
    do
        if which $pkg &> /dev/null; then
            printSubSubsection "$pkg already installed"
        else
            TEMP+=("$pkg")
        fi
    done

    if [[ "${TEMP[@]}" = "0" ]]; then
        $INSTALL $TEMP
        printSubsection "packages installed successfully"
    fi

}

stowit() {
    tmp=$PWD
    src=$1
    # -v verbose
    # -R recursive
    # -t target
    # -d delete
    args="-v -R -t"
    if [ "$1" = "d" ]; then
        args="-D $args"
        src=$2
    fi
    cd $src
    stow $args ~ .
    cd $tmp
}

aliasit(){
    a=$1
    cmd=$2
    if [ "$1" = "d" ]; then
        a=$2
        # remove the line with sed
    else
        echo "alias $a=$cmd" >> $HOME/.aliases
    fi

    source $HOME/.aliases
}

exportit(){
    a=$1
    cmd=$2
    if [ "$1" = "d" ]; then
        a=$2
        # remove the line with sed
    else
        echo "export $a=$cmd" >> $HOME/.exports
    fi

    source $HOME/.exports
}

log(){
    if [ -f /tmp/dotfiles_verbose ]; then
        echo $1
    fi
}

