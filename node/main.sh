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
    sudo npm install -g $1
  fi 
}

printSection "Node.JS, useful packages and tools"

printSubsection "Node.JS"

if which node &> /dev/null; then
  printSubSubsection "Node already installed"
else
  printSubSubsection "Installing node"
  case $OS in
    "Darwin")
      sudo $INSTALL node
      ;;
    "Linux")
      curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
      sudo $INSTALL nodejs
      sudo $INSTALL npm
      ;;
    "*")
      ;;
  esac
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
installNodePackage "grunt-cli"

# eslint
if which eslint &> /dev/null; then
  printSubSubsection "eslint already installed"
else
  printSubSubsection "Installing eslint"
  sudo npm install -g eslint
  sudo npm install -g eslint-plugin-json
  sudo npm install -g eslint-config-hapi
fi
if [ -L $HOME/.eslintrc ]; then
  mv $HOME/.eslintrc $HOME/.eslintrc.old
fi
ln -s $BASEDIR/eslintrc $HOME/.eslintrc

# hapi-app-generator
installNodePackage "hapi-app-generator"

# n
installNodePackage "n"

# npm-check-updates
installNodePackage "npm-check-updates"

# caminte-cli
#installNodePackage "caminte-cli" # cross-db ORM, but this is a client. You still need to install the caminte package in your app.

# conventional-changelog-cli 
installNodePackage "conventional-changelog-cli"

# conventional-commits-detector
installNodePackage "conventional-commits-detector"

# trash
installNodePackage "trash"

# conventional-recommended-bump
installNodePackage "conventional-recommended-bump"

# json
installNodePackage "json"
