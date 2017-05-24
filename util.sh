#!/bin/bash

##
# File: util.sh
# Author: @giovanebribeiro
# Created: 23/05/2017
# Description: Auxiliary funcions to install and configure the listed services and tools
##

function install(){
    PACKAGE_NAME=$1
    OS=`uname` 

    case $OS in
      "Darwin") #MacOS
        # we use homebrew
        echo "MacOS" 
        ;;
      "Linux")
        # we must use the file information about the installer command.
        echo "Linux"
        ;;
      "*")
        ;;
    esac


}
