source $PWD/__setup/util.sh

install(){
    printSection "NODE.JS"

    if [ ! -d $HOME/.nvm ]; then
        printSubSubsection "nvm (and LTS version of node)"
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
        export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
        nvm install --lts # this installs the last LTS version of node
        nvm use --lts # this installs the last LTS version of node
    else
        printSubSubsection "nvm (and LTS version of node) already installed"
    fi
    
    if [ ! -f $HOME/.npmrc ]; then
      printSubSubsection "Loading npm informations"
      npm login
    fi
    
    # npm-check-updates
    installNodePackage "npm-check-updates"
    
    # hapi-app-generator
    installNodePackage "hapi-app-generator"

    stowit $PWD/node/base
}

uninstall(){
    echo "To be implemented"
}
