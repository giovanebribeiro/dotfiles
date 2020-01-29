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

echo $PWD > "$LOC_FILE"
printOK
