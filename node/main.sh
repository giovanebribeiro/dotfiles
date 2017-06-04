source $PWD/common/util.sh

BASEDIR=`dirname "$0"`
BASEDIR=$( cd $BASEDIR && pwd )
INSTALL=$(cat $CMD_FILE)

OS=`uname`

function installNodePackage(){
  if which $1 &> /dev/null; then
    printSubSubsection "$1 already installed"
  else
    printSubSubsection "Installing $1"
    case $OS in 
      "Darwin")
        npm install -g $1
        ;;
      "Linux")
        sudo npm install -g $1
        ;;
      "*")
        printError "Unknown OS"
        ;;
    esac
  fi 
}

printSection "Node.JS, useful packages and tools"

printSubsection "Node.JS"

if which node &> /dev/null; then
  printSubSubsection "Node already installed"
else
  printSubSubsection "Installing node"
  sudo $INSTALL node
fi

if [ ! -f $HOME/.npmrc ]; then
  printSubSubsection "Loading npm informations"
  npm set init.author.name "Giovane Boaviagem"
  npm set init.author.email "giovanebribeiro@gmail.com"
  npm set init.author.url "http://about.me/giovanebribeiro"
  npm adduser
fi

# pm2
installNodePackage "pm2"

# vtop
installNodePackage "vtop"

# bower
installNodePackage "bower"

# grunt (must be installed as administrator all times)
if which grunt &> /dev/null; then
  printSubSubsection "Grunt already installed"
else
  printSubSubsection "Installing grunt"
  sudo npm install -g grunt-cli
fi

# eslint
installNodePackage "eslint"
if [ -L $HOME/.eslintrc ]; then
  mv $HOME/.eslintrc $HOME/.eslintrc.old
fi
ln -s $BASEDIR/eslintrc $HOME/.eslintrc

# eslint-plugin-json
installNodePackage "eslint-plugin-json"

# hapi-app-generator
installNodePackage "hapi-app-generator"

# n
installNodePackage "n"

# npm-check-updates
installNodePackage "npm-check-updates"
