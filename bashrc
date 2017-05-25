#
# ~/.bashrc
# Author: Giovane Boaviagem (about.me/giovanebribeiro)
#


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

##################################
###### SECTION 1: CONSTANTS ######
##################################

### Color table
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

# Various variables you might want for your PS1 prompt instead
Time12h="\T"
Time12a="\@"
PathShort="\w"
PathFull="\W"
NewLine="\n"
Jobs="\j"

################################
###### SECTION 2: IMPORTS ######
################################

# EXPORTS
# if exports file exists, load it!
[ -r "$HOME/.exports.sh" ] && source "$HOME/.exports.sh" &>/dev/null

# ALIASES
# if aliases file exists, load it!
[ -r "$HOME/.aliases.sh" ] && source "$HOME/.aliases.sh" &>/dev/null

##################################
###### SECTION 3: FUNCTIONS ######
##################################

##
# returns the current git branch name
##
parse_git_branch(){
  git --version | grep "git" > /dev/null 2>&1 || return # check if git is installed
  echo `git status 2> /dev/null` | grep "nothing to commit" > /dev/null 2>&1
  if [ "$?" -eq "0" ] ; then
    echo ${bGreen}`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
  else
    echo ${bRed}`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
  fi
}

##
# Converts a unicode code (like '\u250c')
# in a set readable by PS1 var ()
##
unicode_to_hex(){
  echo -e $1 | hexdump -v -e '/1 "%03o "' | awk '{print "\\" $1 "\\" $2 "\\" $3 }'
}

##
# Set the title of console
##
title() { 
#  printf '\e]2;%s\a' "$*";
  echo -n -e "\033]0;$*\007";
}



#####################################
###### SECTION 4: PS1 VARIABLE ######
#####################################

# Output:
# ┌[today time]-[username@host]-[current path]-[number of files, total sizeof all files]
#⌥
#⌥
#├
#⬆ #⬇
#Ξ
#
# ${bCyan}\u@\h${reset} (giovanebribeiro@localhost)

export PS1="\[\n${reset}\342\224\214 ${bYellow}\w${reset} - ${bBlue}$(ls -l | wc -l | sed 's: ::g') files, \$(ls -lah | grep -m 1 total | sed 's/total //')b${reset}\]\
\[\n\342\224\234 \$(parse_git_branch)${reset} - \
\$(\
\$(git status > /dev/null 2>&1);
  if [ \$? == 0 ]; then
  OUT_PULL=\$(git status 2> /dev/null | grep 'branch is behind');
  OUT_OK=\$(git status 2> /dev/null | grep 'working directory clean');
  OUT_PUSH=\$(git status 2> /dev/null | grep 'branch is ahead'); 
  if [ \"\$OUT_PULL\" != \"\" ]; then
  echo \"\"${bYellow}\"\342\254\207\";
  elif [ \"\$OUT_PUSH\" != \"\" ]; then
  echo \"\"${bYellow}\"\342\254\206\";
  else
  echo \"\"${bGreen}\"\316\236\012\";
  fi
  fi
  )${reset} - \$(if [[ \$? == 0 ]]; then echo ${bGreen}\"\342\234\223\"; else echo ${bRed}\"\342\234\227\"; fi)${reset} \]\
  \[\n\342\224\224 \$ "
#  \[\n\342\224\224[\$]\342\206\222 "
#export PS1="$"
#export PS1="\[\n${bWhite}\342\224\214[${rBlue}\d \@${bWhite}]-[\$(if [[ \$? == 0 ]]; then echo ${bGreen}\"\342\234\223\"; else echo ${bRed}\"\342\234\227\"; fi)${bWhite}]-[${rCyan}\u@\h${bWhite}]\
#  \n\342\224\234[${rYellow}\w${bWhite}]-[${rYellow}$(ls -l | wc -l | sed 's: ::g') files, \$(ls -lah | grep -m 1 total | sed 's/total //')b${bWhite}]\
#  \n\342\224\234[\$(parse_git_branch)${bWhite}]-[\
#\$(\
#  \$(git status > /dev/null 2>&1);
#  if [ \$? == 0 ]; then
#    OUT_PULL=\$(git status 2> /dev/null | grep 'branch is behind');
#    OUT_OK=\$(git status 2> /dev/null | grep 'working directory clean');
#    OUT_PUSH=\$(git status 2> /dev/null | grep 'branch is ahead'); 
#    if [ \"\$OUT_PULL\" != \"\" ]; then
#      echo \" \"${bYellow}\"\342\254\207\";
#    elif [ \"\$OUT_PUSH\" != \"\" ]; then
#      echo \" \"${bYellow}\"\342\254\206\";
#    else
#      echo \" \"${bGreen}\"\316\236\012\";
#    fi
#  fi
#) ${bWhite}]\

# and to finish, export it
# if the system is linux, ps1 will be in linux format. Otherwise, in mac format.
#if [ "$(uname -a | grep "Linux")" != "" ] ; then
#  export PS1='\n\e[1;36m[\w]\e[1;33m(\h)\e[0m\n\u \e[0;31m$(parse_git_branch) \e[1;37m->\e[0m ' 
#else
#  export PS1='\n\[$(tput setaf 6)\][\w]$(tput bold)$(tput setaf 3)(\h) \n\[$(tput sgr0)\]\u\[$(tput setaf 1)\]$(parse_git_branch)\[$(tput sgr0)\] \[$(tput bold)\]\[$(tput setaf 7)\]-> \[$(tput sgr0)\]'
#fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
