source $PWD/common/util.sh

BASEDIR=`dirname "$0"`
BASEDIR=$( cd $BASEDIR && pwd )
INSTALL=$(cat $CMD_FILE)

OS=`uname`

printSection "Rust, useful packages and tools"

printSubsection "Rust"

if which rustc &> /dev/null; then
  printSubSubsection "Rust already installed"
else
  printSubSubsection "Installing Rust"
  curl https://sh.rustup.rs -sSf | sh
  # Will allow us to use cargo in this execution
  export PATH=$HOME/.cargo/bin:$PATH
fi

printSubSubsection "Enable vim auto-complete for Rust"
python3 $HOME/.vim/bundle/YouCompleteMe/install.py --rust-completer

printSubsection "Install what (network packet sniffer)"
cargo install what
if [ -f /usr/local/bin/what ]; then
    rm /usr/local/bin/what
fi
sudo ln -s $HOME/.cargo/bin/what /usr/local/bin/what
