# dotfiles
My dotfiles and scripts to make my life easier. Works on MacOSX and Linux (Debian and variants). Strongly inspired on [this](https://github.com/davidsonfellipe/dotfiles) project (Thanks Davidson!! :D)

## How can I use it?

```
$ bash ./install.sh -h
  __  __         ____        _    __ _ _
 |  \/  |_   _  |  _ \  ___ | |_ / _(_) | ___  ___
 | |\/| | | | | | | | |/ _ \| __| |_| | |/ _ \/ __|
 | |  | | |_| | | |_| | (_) | |_|  _| | |  __/\__ \
 |_|  |_|\__, | |____/ \___/ \__|_| |_|_|\___||___/
         |___/

v
Usage: ./install.sh [options]
   h      Print this help and version
   v      Print the version
   b      Installs basic tools and zshrc
   i      Installs the tools for ide (vim, todo.txt, git configs, ctags, etc)
   r      Install and confgure Rust
   n      Install and confgure Node.js
   a      Install everything. Equivalent to './install.sh -birn'
   c      Install complementary tools, zshthemes, etc.

## What do I use?

* shell: zsh (with framework oh-my-zsh)
* editor: vim
* terminal manager: tmux
