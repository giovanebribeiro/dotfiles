#!/bin/bash

OS=`uname`
BASEDIR=`dirname "$0"`
BASEDIR=$( cd $BASEDIR && pwd )

echo "## Terminal files and general configurations"
if [ ! -f "$HOME/.aliases" ]; then
  echo "* Installing aliases..."
  ln -s $BASEDIR/aliases_$OS.sh $HOME/.aliases
fi

if [ ! -f "$HOME/.exports" ]; then
  echo "* Installing exports..."
  ln -s $BASEDIR/exports_$OS.sh $HOME/.exports
fi

case $OS in
  "Darwin")
    if [ ! -f "$HOME/.bash_profile" ]; then
      echo "* Installing bash_profile..."
      ln -s $BASEDIR/bashrc $HOME/.bash_profile
      source $HOME/.bash_profile
    fi
    ;;
  "Linux")
    if [ ! -f "$HOME/.bashrc" ]; then
      echo "* Installing bashrc"
      mv $HOME/.bashrc $HOME/.bashrc.old
      ln -s $BASEDIR/bashrc $HOME/.bashrc
      source $HOME/.bashrc
    fi
    ;;
  "*")
    echo "* Unknown OS"
    ;;
esac
echo "## Terminal files and general configurations... OK"
