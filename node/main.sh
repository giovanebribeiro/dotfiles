source $PWD/common/util.sh

BASEDIR=`dirname "$0"`
BASEDIR=$( cd $BASEDIR && pwd )
INSTALL=$(cat $CMD_FILE)

OS=`uname`



printSection "Node.JS, useful packages and tools"

printSubsection "Node.JS"

if which node &> /dev/null; then
  printSubSubsection "Node already installed"
else
  printSubSubsection "Installing node"
  case $OS in
    "Darwin")
      $INSTALL node
      ;;
    "Linux")
      curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
      sudo $INSTALL nodejs
      sudo $INSTALL npm
      ;;
    "*")
      ;;
  esac
fi

if [ ! -f $HOME/.npmrc ]; then
  printSubSubsection "Loading npm informations"
  npm login
fi
    
printSubSubsection "Enable vim auto-complete for Node"
python3 $HOME/.vim/bundle/YouCompleteMe/install.py --ts-completer

# npm-check-updates
installNodePackage "npm-check-updates"

  
if [ -L $HOME/.eslintrc ]; then
    mv $HOME/.eslintrc $HOME/.eslintrc.old
fi
ln -s $BASEDIR/eslintrc $HOME/.eslintrc

# hapi-app-generator
installNodePackage "hapi-app-generator"
