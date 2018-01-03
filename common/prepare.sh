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

      echo "brew install" > $CMD_FILE
      ;;
    "Linux")
      echo "apt-get install" > $CMD_FILE
      # Needed for many things...
      apt-get install build-essential
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
