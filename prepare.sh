source util.sh

printSection "Check the package managers"

if [ ! -f $CMD_FILE ]; then

  OS=`uname`
  case $OS in 
    "Darwin")
      if which brew &> /dev/null; then
        echo "Homebrew already installed."
      else
        run "ruby -e '$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)'" "Instalando homebrew"
      fi

      echo "brew install" > $CMD_FILE
      ;;
    "Linux")
      read -p "It seems you have a linux. What is your install command? " RUN
      
      echo $RUN > $CMD_FILE
      ;;
    "*")
      printError "Unknown OS"
      ;;
  esac

fi

printSection "Check the package managers... OK"
