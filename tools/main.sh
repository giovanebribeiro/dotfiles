source $PWD/common/util.sh

INSTALL=$(cat $CMD_FILE)

printSection "Install useful tools"

printSubsection "cURL"
if which curl &> /dev/null; then
  printSubSubsection "cURL already installed"
else
  sudo $INSTALL curl
  printSubSubsection "cURL installed successfully"
fi

printOK
