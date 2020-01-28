source $PWD/__setup/util.sh

printSubsection "install packages based on OS"
OS=`uname`
case $OS in 
"Darwin")
  if which brew &> /dev/null; then
    printSubSubsection "Homebrew already installed."
  else
    ruby -e '$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)'
  fi
  ;;
"Linux")
  # Needed for many things...
  installPkg build-essential zsh python-dev python3-dev x11-xserver-utils git
  ;;
"*")
  printError "Unknown OS"
  ;;
esac

installPkg stow curl wget cmake

#printSubsection "Rust"
#if which rustc &> /dev/null; then
#  printSubSubsection "Rust already installed"
#else
#  printSubSubsection "Installing Rust"
#  curl https://sh.rustup.rs -sSf | sh
#  # Will allow us to use cargo in this execution
#  export PATH=$HOME/.cargo/bin:$PATH
#fi
#
#if [ ! -f $HOME/.cargo/bin/what ]; then
#    printSubSubsection "Install what (network packet sniffer)"
#    cargo install what
#    sudo ln -s $HOME/.cargo/bin/what /usr/local/bin/what
#else
#    printSubSubsection "what already installed"
#fi
#
#if [ ! -f $HOME/.cargo/bin/habitctl ]; then
#    printSubSubsection "Install habitctl (habit tracker)"
#    git clone https://github.com/blinry/habitctl
#    cd habitctl
#    cargo build --release
#    mv target/release/habitctl $HOME/.cargo/bin/habitctl
#    cd $BASEDIR
#    rm -rf $BASEDIR/habitctl
#else
#    printSubSubsection "habitctl (habit tracker) already installed"
#fi
#
#printSubsection "Node.JS"
#if [ ! -d $HOME/.nvm ]; then
#    printSubSubsection "nvm (and LTS version of node)"
#    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
#    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
#    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
#    nvm install --lts # this installs the last LTS version of node
#    nvm use --lts # this installs the last LTS version of node
#else
#    printSubSubsection "nvm (and LTS version of node) already installed"
#fi
#
## vtop
#installNodePackage "vtop"
#
printOK
