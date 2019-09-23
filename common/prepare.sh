source $PWD/common/util.sh

printSection "Check the package managers"

if [ ! -f $CMD_FILE ]; then

  OS=`uname`
  case $OS in 
    "Darwin")
      if which brew &> /dev/null; then
        printSubsection "Homebrew already installed."
      else
        ruby -e '$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)'
      fi

      brew install cmake
      echo "brew install" > $CMD_FILE
      ;;
    "Linux")
      echo "sudo apt-get install" > $CMD_FILE
      # Needed for many things...
      sudo apt-get install build-essential cmake python-dev python3-dev x11-xserver-utils
      ;;
    "*")
      printError "Unknown OS"
      ;;
  esac

fi

printOK

printSection "Save the project location in a temp file"
echo $PWD > "$LOC_FILE"
printOK
