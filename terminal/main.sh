OS=`uname`
BASEDIR=`dirname "$0"`
BASEDIR=$( cd $BASEDIR && pwd )

source "$PWD/common/util.sh"

printSection "Terminal files and general configurations"
if [ ! -f "$HOME/.aliases" ]; then
  printSubsection "Installing aliases..."
  ln -s $BASEDIR/aliases_$OS.sh $HOME/.aliases
fi

if [ ! -f "$HOME/.exports" ]; then
  printSubsection "Installing exports..."
  ln -s $BASEDIR/exports_$OS.sh $HOME/.exports
fi

case $OS in
  "Darwin")
    if [ ! -f "$HOME/.bash_profile" ]; then
      printSubsection "Installing bash_profile..."
      ln -s $BASEDIR/bashrc $HOME/.bash_profile
      source $HOME/.bash_profile
    fi
    ;;
  "Linux")
    if [ ! -f "$HOME/.bashrc" ]; then
      printSubsection "Installing bashrc"
      mv $HOME/.bashrc $HOME/.bashrc.old
      ln -s $BASEDIR/bashrc $HOME/.bashrc
      source $HOME/.bashrc
    fi
    ;;
  "*")
    printError "Unknown OS"
    ;;
esac
printSection "Terminal files and general configurations... OK"
