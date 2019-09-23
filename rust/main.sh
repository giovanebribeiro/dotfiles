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

basicSet(){
  echo "To be implemented"
}

while getopts b OPT
do
  case "${OPT}"
  in 
    b) basicSet ;;
    *) echo "Unknown option: ${OPT}" ;;
  esac
done
