#!/bin/bash

#ping -c 3 "google.com" &> output.log &
#pid=$!
#progress "installing:" $pid


echo "  __  __         ____        _    __ _ _            "
echo " |  \/  |_   _  |  _ \  ___ | |_ / _(_) | ___  ___  "
echo " | |\/| | | | | | | | |/ _ \| __| |_| | |/ _ \/ __| "
echo " | |  | | |_| | | |_| | (_) | |_|  _| | |  __/\__ \ "
echo " |_|  |_|\__, | |____/ \___/ \__|_| |_|_|\___||___/ "
echo "         |___/                                      "
echo 

bash prepare.sh

bash terminal/main.sh

#case $OS in
#  "Darwin")
#    if which brew &> /dev/null; then
#      echo "Homebrew already installed."
#    else
#      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" &
#      pid=$!
#      progress "Installing homebrew "
#    fi
#
#    init_workspace
#    ;;
#  "Linux")
#    read -p "It seems you have a linux. What is your package manager? (Default: apt-get)" RUN
#    if [[ -e $RUN ]]; then
#      echo "apt-get" > $PWD/tmp_pkg
#    else
#      echo "$RUN" > $PWD/tmp_pkg
#    fi
#    ;;
#  "*") echo "Undentified OS" ;;
#esac


