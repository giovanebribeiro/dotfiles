#!/bin/sh

##
# Color table
##
reset=$(tput sgr0)

## regular colors
rRed=$(tput setaf 1)
rGreen=$(tput setaf 2)
rYellow=$(tput setaf 3)
rBlue=$(tput setaf 4)
rMagenta=$(tput setaf 5)
rCyan=$(tput setaf 6)
rWhite=$(tput setaf 7)

## bold colors
bRed=$(tput bold)$(tput setaf 1)
bGreen=$(tput bold)$(tput setaf 2)
bYellow=$(tput bold)$(tput setaf 3)
bBlue=$(tput bold)$(tput setaf 4)
bMagenta=$(tput bold)$(tput setaf 5)
bCyan=$(tput bold)$(tput setaf 6)
bWhite=$(tput bold)$(tput setaf 7)

## underline colors
uRed=$(tput sgr 0 1)$(tput setaf 1)
uGreen=$(tput sgr 0 1)$(tput setaf 1)
uYellow=$(tput sgr 0 1)$(tput setaf 1)
uBlue=$(tput sgr 0 1)$(tput setaf 1)
uMagenta=$(tput sgr 0 1)$(tput setaf 1)
uCyan=$(tput sgr 0 1)$(tput setaf 1)
uWhite=$(tput sgr 0 1)$(tput setaf 1)

##
# Other constants
##
LOG_FILE=output.log
check=${bGreen}\342\234\223${reset}
