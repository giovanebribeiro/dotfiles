#!/bin/sh

alias ps="ps aux"
alias ls='ls -G'
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias cotoco='ssh -L 4200:localhost:4243 giovane@cotoco -p 8051'
alias enableRemoteCP='sudo cp ~/Dropbox/crashplan_infos/cotoco.ui_info /Library/Application\ Support/CrashPlan/.ui_info'
alias enableLocalCP='sudo cp ~/Dropbox/crashplan_infos/narsil.ui_info /Library/Application\ Support/CrashPlan/.ui_info'
alias todo='bash ./todo.txt/todo.sh'
