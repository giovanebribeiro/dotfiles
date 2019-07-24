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
    [ "$OS" == "Darwin" ] && npm install -g $1
    [ "$OS" == "Linux" ] && sudo npm install -g $1
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
  npm set init.author.name "Giovane Boaviagem"
  npm set init.author.email "giovanebribeiro@gmail.com"
  npm set init.author.url "http://about.me/giovanebribeiro"
  npm adduser
fi

basicSet(){
  # n
  installNodePackage "n"
  # npm-check-updates
  installNodePackage "npm-check-updates"
  # vtop
  installNodePackage "vtop"
  # eslint
  if which eslint &> /dev/null; then
    printSubSubsection "eslint already installed"
  else
    installNodePackage "eslint"
    installNodePackage "eslint-plugin-json"
    installNodePackage "eslint-plugin-hapi"
  fi
  if [ -L $HOME/.eslintrc ]; then
    mv $HOME/.eslintrc $HOME/.eslintrc.old
  fi
  ln -s $BASEDIR/eslintrc $HOME/.eslintrc
}

backendSet(){
  # hapi-app-generator
  installNodePackage "hapi-app-generator"
  # pm2
  installNodePackage "pm2"
}

# the basic set is always executed
basicSet

while getopts b OPT
do
  case "${OPT}"
  in 
    b) basicSet; backendSet ;;
    *) echo "Unknown option: ${OPT}" ;;
  esac
done

#frontendSet(){
  # bower
  #installNodePackage "bower"
  # grunt (must be installed as administrator all times)
  #installNodePackage "grunt-cli"
  # gulp?
#}
