source $PWD/__setup/util.sh

printSubsection "MAKE SOME PREPARATIONS"
OS=`uname`
case $OS in 
"Darwin")
  if which brew &> /dev/null; then
    printSubSubsection "Homebrew already installed."
  else
    ruby -e '$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)'
  fi
  brew install mono go
  ;;
"Linux")
  # Needed for many things...
  installPkg build-essential zsh python-dev python3-dev x11-xserver-utils git
  ;;
"*")
  printError "Unknown OS"
  ;;
esac

installPkg stow curl wget cmake

if [ ! -d $HOME/.nvm ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
    nvm install --lts # this installs the last LTS version of node
    nvm use --lts # this installs the last LTS version of node
else
    printSubSubsection "nvm (and LTS version of node) already installed"
fi

echo $PWD > "$LOC_FILE"
printOK
