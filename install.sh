#!/bin/bash

echo "  __  __         ____        _    __ _ _            "
echo " |  \/  |_   _  |  _ \  ___ | |_ / _(_) | ___  ___  "
echo " | |\/| | | | | | | | |/ _ \| __| |_| | |/ _ \/ __| "
echo " | |  | | |_| | | |_| | (_) | |_|  _| | |  __/\__ \ "
echo " |_|  |_|\__, | |____/ \___/ \__|_| |_|_|\___||___/ "
echo "         |___/                                      "
echo

VERSION=1.2.0

version(){
  if [ -z ${help_printed} ]; then
    echo v${VERSION}
  fi
}

_help(){
  if [ -z ${version_printed} ]; then
    version
  fi
  echo "Usage: $0 [options]"
  echo "   h      Print this help and version"
  echo "   v      Print the version"
  echo "   b      Installs basic tools and bashrc"
  echo "   i      Installs the tools for ide (vim, todo.txt, git configs, ctags, etc)"
  echo "   m      Install and confgure the MongoDB"
  echo "   n      Install and confgure Node.js"
  echo "   a      Install everything. Equivalent to '$0 -bimn'"
  echo 
}

if [ "$#" -eq "0" ]; then
  _help
  exit 0
fi

pre(){
  bash common/prepare.sh
  echo
  bash tools/main.sh
}

basic(){
  pre
  echo
  bash terminal/main.sh
}

ide(){
  [ -z ${basic_executed} ] && basic
  echo
  bash ide/main.sh
}

database_mongo(){
  [ -z ${basic_executed} ] && basic
  echo
  bash database-mongo/main.sh
}

node(){
  [ -z ${basic_executed} ] && basic
    echo
  bash node/main.sh
}

all(){
  basic
  ide
  node
  database_mongo
}

while getopts hvbimna OP
do
  case "${OP}"
  in
    h) _help; help_printed=1 ;;
    v) version; version_printed=1 ;;
    b) basic; basic_executed=1 ;;
    i) ide; ide_executed=1 ;;
    m) database_mongo; db_mongo_executed=1 ;;
    n) node; node_executed=1 ;;
    a) all ;;
    *) echo "Unknown option: ${OP}"; _help ;;
  esac
done
