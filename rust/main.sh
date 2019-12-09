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
fi

printSubSubsection "Enable vim auto-complete for Rust"
python3 $HOME/.vim/bundle/YouCompleteMe/install.py --rust-completer
