# dotfiles
My dotfiles and scripts to make my life easier. Works on MacOSX and Linux (Debian and variants). Strongly inspired on [this](https://github.com/davidsonfellipe/dotfiles) project (Thanks Davidson!! :D)

## How can I use it?

```
$ ./install.sh
  __  __         ____        _    __ _ _
 |  \/  |_   _  |  _ \  ___ | |_ / _(_) | ___  ___
 | |\/| | | | | | | | |/ _ \| __| |_| | |/ _ \/ __|
 | |  | | |_| | | |_| | (_) | |_|  _| | |  __/\__ \
 |_|  |_|\__, | |____/ \___/ \__|_| |_|_|\___||___/
         |___/

v1.1.0
Usage: ./install.sh [options]
   h      Print this help and version
   v      Print the version
   b      Installs basic tools and bashrc
   i      Installs the tools for ide (vim, todo.txt, git configs, ctags, etc)
   m      Install and confgure the MongoDB
   n      Install and confgure Node.js
   a      Install everything. Equivalent to './install.sh -bimn'
```

## PS1 layout: 

```
# when $PWD is not a git repo:
~ $
|_ actual folder

# when $PWD is a git repo:
dotfiles master [origin/master(=)] $
  |         |           |      |_ git workspace status (^ - Have changes to push, v - have changes to pull, = - workspace is sync)
  |         |           |________ remote branch 
  |         |____________________ local branch
  |______________________________ actual folder
```
