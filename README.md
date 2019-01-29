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
┌ narsil [ Kernel Darwin 18.2.0 ]            # Hostname and kernel version
├ ~/workspace/dotfiles - 27 files, 96b       # PWD + how many files on folder + total size
├ master [origin/master] - ⬆ - ✓             # actual git branch + remote branch + workspace status + status of last executed command
└ $

# workspace status:
⬆  - Have changes to push
Ξ  - No changes to push or pull. Workspace is sync with remote
⬇  - Have changes to pull
```

## Git aliases

```
$ cat ~/.gitconfig

...

[alias]
  clean-closed-branches = remote prune origin
  st = status -sb
  ll = log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)%Creset' --abbrev-commit
  f = fetch
  fc = "!git fetch; git checkout $1"
  ps = push
  psuo = push --set-upstream origin 
  pl = pull
  plom = pull origin master
  # Show active users on repo in last 6 months
  active = shortlog --numbered --email --summary --no-merges --since="6 months"
  aa = add --all
  cam = commit -am
  mom = merge origin/master
  ck = checkout
  ckb = checkout -b
  ckm = checkout master
  rso = remote show origin
  # collect the commits since the last tag
  changelog = "!git log $(git describe --tags --abbrev=0)..HEAD --pretty=format:'%h %s'"

...

```
