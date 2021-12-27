source $PWD/__setup/util.sh

install(){
    printSection "NODE.JS"

    if [ ! -f $HOME/.npmrc ]; then
      printSubSubsection "Loading npm informations"
      npm login
    fi
    
    # npm-check-updates
    installNodePackage "npm-check-updates"
    
    # hapi-app-generator
    installNodePackage "hapi-app-generator"
    
    # hapi client of vue.js
    installNodePackage "@vue/cli"

    stowit $PWD/node/base
}

uninstall(){
    echo "To be implemented"
}
