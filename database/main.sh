source $PWD/common/util.sh

BASEDIR=`dirname "$0"`
BASEDIR=$( cd $BASEDIR && pwd )
INSTALL=$(cat $CMD_FILE)
OS=`uname`

printSection "Database configurations"

printSubsection "MongoDB"
if which mongo &> /dev/null; then
  printSubSubsection "MongoDB already installed"
else
  printSubSubsection "Installing MongoDB"
  case $OS in
    "Darwin")
      $INSTALL mongodb
      ;;
    "Linux")
      sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
      echo "deb [ arch=amd64,arm64  ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
      sudo apt-get update
      sudo $INSTALL mongodb-org
      ;;
    "*")
      ;;
  esac
fi
printOK
