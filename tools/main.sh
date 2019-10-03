source $PWD/common/util.sh

INSTALL=$(cat $CMD_FILE)

printSection "Install useful tools"

printSubsection "cURL"
if which curl &> /dev/null; then
  printSubSubsection "cURL already installed"
else
  $INSTALL curl
  printSubSubsection "cURL installed successfully"
fi

printSubsection "neofetch"
if command -v neofetch >/dev/null 2>&1; then
  printSubSubsection "neofetch already installed"
else
  $INSTALL neofetch
  printSubSubsection "neofetch installed successfully"
fi

printSubsection "cmatrix"
if command -v cmatrix >/dev/null 2>&1; then
  printSubSubsection "cmatrix already installed"
else
  $INSTALL cmatrix
  printSubSubsection "cmatrix installed successfully"
fi

printOK
