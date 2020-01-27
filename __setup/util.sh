LOG_FILE=$HOME/dotfiles.log
LOC_FILE=$HOME/.dotfiles-loc
CMD_FILE=$HOME/.install_cmd

OS=`uname`
INSTALL=$(cat $CMD_FILE)

function printSection() { echo "# $1";  }
function printSubsection() { echo; echo "- $1"; echo;}
function printSubSubsection() { echo "* $1"; }
function printError() { echo "x $1"; }
function printOK() { echo; echo "...OK"; }

function installPkg() {
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

function stowit() {
    src=$1
# run the stow command for the passed in directory ($2) in location $1
stowit() {
    usr=$1
    app=$2
    # -v verbose
    # -R recursive
    # -t target
    stow -v -R -t ${usr} ${app}
}
}

function installNodePackage(){
  if which $1 &> /dev/null; then
    printSubSubsection "$1 already installed"
  else
    printSubSubsection "Installing $1"
    [ "$OS" == "Darwin" ] && npm install -g $1
    [ "$OS" == "Linux" ] && sudo npm install -g $1
  fi 
}
