source $PWD/common/util.sh

BASEDIR=`dirname "$0"`
BASEDIR=$( cd $BASEDIR && pwd )
INSTALL=$(cat $CMD_FILE)

OS=`uname`

printSection "Rust, useful packages and tools"


printSubSubsection "Enable vim auto-complete for Rust"
python3 $HOME/.vim/bundle/YouCompleteMe/install.py --rust-completer
