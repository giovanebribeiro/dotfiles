#!/bin/bash

source . util.sh

OS=`uname`

case $OS in
  "Darwin")
    echo "brew" > $PWD/tmp_pkg
    ;;
  "Linux")
    read -p "It seems you have a linux. What is your package manager? (Default: apt-get)" RUN
    if [[ -e $RUN ]]; then
      echo "apt-get" > $PWD/tmp_pkg
    else
      echo "$RUN" > $PWD/tmp_pkg
    fi
    ;;
  "*") echo "Undentified OS" ;;
esac
