#!/bin/sh

export CLICOLOR='true'
export LSCOLORS="gxfxcxdxbxCgCdabagacad"
export EDITOR='/usr/bin/vim'
export PATH=$PATH:'/Users/giovanebribeiro/programas/apache-maven/3.5.2/bin'
export PATH=$PATH:'/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome:/Users/giovanebribeiro/programas/android-sdk-macosx/platform-tools'
export PATH=$PATH:'/Users/giovanebribeiro/Library/Android/sdk/platform-tools'
export PATH=$PATH:'/Users/giovanebribeiro/Library/Python/2.7/bin'
export PATH=$PATH

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

source $HOME/todo.txt/todo_completion
