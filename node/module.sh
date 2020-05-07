source $PWD/__setup/util.sh

installNodePackage(){
  if which $1 &> /dev/null; then
    printSubSubsection "$1 already installed"
  else
    printSubSubsection "Installing $1"
    [ "$OS" == "Darwin" ] && npm install -g $1
    [ "$OS" == "Linux" ] && sudo npm install -g $1
  fi 
}

install(){
    printSection "NODE.JS"

    # Node.JS is already installed in "pre.sh" script
    
    if [ ! -f $HOME/.npmrc ]; then
      printSubSubsection "Loading npm informations"
      npm login
    fi
    
    # npm-check-updates
    installNodePackage "npm-check-updates"
    
    # hapi-app-generator
    installNodePackage "hapi-app-generator"
    
    # hapi client of vue.jsr
    installNodePackage "@vue/cli"

    stowit $PWD/node/base
}

uninstall(){
    echo "To be implemented"
}
