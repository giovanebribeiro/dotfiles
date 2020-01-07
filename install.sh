#!/bin/bash

echo "  __  __         ____        _    __ _ _            "
echo " |  \/  |_   _  |  _ \  ___ | |_ / _(_) | ___  ___  "
echo " | |\/| | | | | | | | |/ _ \| __| |_| | |/ _ \/ __| "
echo " | |  | | |_| | | |_| | (_) | |_|  _| | |  __/\__ \ "
echo " |_|  |_|\__, | |____/ \___/ \__|_| |_|_|\___||___/ "
echo "         |___/                                      "
echo

pre(){
  bash tools/main.sh
  pre_executed=1
}

terminal(){
  [ -z ${pre_executed} ] && pre
  echo
  bash terminal/main.sh
}

complement(){
  [ -z ${terminal_executed} ] && echo "Run first the '-b' option before execute this one" && exit 0
  echo
  bash basic/complement.sh
}

ide(){
  [ -z ${pre_executed} ] && pre
  echo
  bash ide/main.sh
}

node(){
  [ -z ${ide_executed} ] && ide
  echo
  bash node/main.sh
}

rust(){
  [ -z ${ide_executed} ] && ide
  echo
  bash rust/main.sh
}

all(){
  ide
  node
  rust
  basic
}

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
  echo "   t      Install terminal dotfiles and dependencies"
  echo "   i      Installs the tools for ide (vim, todo.txt, git configs, ctags, etc)"
  echo "   r      Install and confgure Rust"
  echo "   n      Install and confgure Node.js"
  echo "   a      Install everything. Equivalent to '$0 -birn'"
  echo "   c      Install complementary tools, zshthemes, etc."
  echo 
}

source $PWD/common/util.sh

if [ ! -f $CMD_FILE ]; then
	read -p "What is your command for install apps (ex: brew install, apt-get install, pacman -Sy, etc): " cmd
	echo "sudo $cmd" > $CMD_FILE
fi

if [ "$#" -eq "0" ]; then
  _help
  exit 0
fi

while getopts hvbirna OP
do
  case "${OP}"
  in
    h) _help; help_printed=1 ;;
    v) version; version_printed=1 ;;
    t) terminal; terminal_executed=1 ;;
    i) ide; ide_executed=1 ;;
    r) rust; rust_executed=1 ;;
    n) node; node_executed=1 ;;
    c) complement ;;
    a) all ;;
    *) echo "Unknown option: ${OP}"; _help ;;
  esac
done
