autoload -Uz tetriscurses

OS=`uname`

DOTFILES_LOC=`cat $HOME/.dotfiles-loc`

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

if [ -d "$ZSH" ]; then
    # Set name of the theme to load --- if set to "random", it will
    # load a random theme each time oh-my-zsh is loaded, in which case,
    # to know which specific one was loaded, run: echo $RANDOM_THEME
    # See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
    ZSH_THEME="typewritten"
    #ZSH_TMUX_FIXTERM=true
    #ZSH_TMUX_FIXTERM_WITH_256COLOR="screen-256color"
    # Set list of themes to pick from when loading at random
    # Setting this variable when ZSH_THEME=random will cause zsh to load
    # a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
    # If set to an empty array, this variable will have no effect.
    # ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

    # Uncomment the following line to use case-sensitive completion.
    # CASE_SENSITIVE="true"

    # Uncomment the following line to use hyphen-insensitive completion.
    # Case-sensitive completion must be off. _ and - will be interchangeable.
    # HYPHEN_INSENSITIVE="true"

    # Uncomment the following line to disable bi-weekly auto-update checks.
    # DISABLE_AUTO_UPDATE="true"

    # Uncomment the following line to automatically update without prompting.
    # DISABLE_UPDATE_PROMPT="true"

    # Uncomment the following line to change how often to auto-update (in days).
    # export UPDATE_ZSH_DAYS=13

    # Uncomment the following line if pasting URLs and other text is messed up.
    # DISABLE_MAGIC_FUNCTIONS=true

    # Uncomment the following line to disable colors in ls.
    # DISABLE_LS_COLORS="true"

    # Uncomment the following line to disable auto-setting terminal title.
    # DISABLE_AUTO_TITLE="true"

    # Uncomment the following line to enable command auto-correction.
    # ENABLE_CORRECTION="true"

    # Uncomment the following line to display red dots whilst waiting for completion.
    # COMPLETION_WAITING_DOTS="true"

    # Uncomment the following line if you want to disable marking untracked files
    # under VCS as dirty. This makes repository status check for large repositories
    # much, much faster.
    # DISABLE_UNTRACKED_FILES_DIRTY="true"

    # Uncomment the following line if you want to change the command execution time
    # stamp shown in the history command output.
    # You can set one of the optional three formats:
    # "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
    # or set a custom format using the strftime function format specifications,
    # see 'man strftime' for details.
    # HIST_STAMPS="mm/dd/yyyy"

    # Would you like to use another custom folder than $ZSH/custom?
    # ZSH_CUSTOM=/path/to/new-custom-folder

    # Which plugins would you like to load?
    # Standard plugins can be found in ~/.oh-my-zsh/plugins/*
    # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
    # Example format: plugins=(rails git textmate ruby lighthouse)
    # Add wisely, as too many plugins slow down shell startup.
    plugins=(git)

    source $ZSH/oh-my-zsh.sh
fi

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh_history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

if [ ! -d $HOME/.cargo ]; then
    printSubsection "Installing rustup"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/env
fi

if [ ! -f $HOME/.cargo/bin/btm ]; then
    cargo install -f --git https://github.com/ClementTsang/bottom bottom
    alias oldtop='/usr/bin/top'
    alias top='btm --color gruvbox'
    #alias topster='ytop'
fi

##
# FUNCTIONS
##

fetch() {

    if [ ! -d "$HOME/bin"  ]; then
        mkdir -p $HOME/bin
    fi

    if [ "$OS" = "Darwin" ]; then

        if [ ! -f "$HOME/bin/pfetch"  ]; then
            BASEDIR=`pwd`
            cd /tmp

            wget https://github.com/dylanaraps/pfetch/archive/master.zip
            unzip master.zip
            install pfetch-master/pfetch $HOME/bin/
            ls -l $HOME/bin/pfetch

            cd $BASEDIR
        fi

        pfetch
        exit 0
    fi

    if [ ! -f $HOME/.cargo/bin/treefetch ]; then
        # I'm using my fork because of -bonsai option.
        # But, if you will use this script, install stable treefetch 
        # from original link: https://github.com/angelofallars/treefetch
        cargo install -f --git https://github.com/giovanebribeiro/treefetch treefetch
    fi

    advent_file=~/.advent_start
    date=`date +%Y-%m-%d`
    year=`date -d "$date" +%Y`
    month=`date -d "$date" +%m`
    ((next_year=$year+1))

    if [[ $(date -d "$date + 1week" +%d%a) =~ 0[1-7]dom ]]
    then
        # the given date is the last sunday of the month
        if [ $month -eq 11 ]; then
            echo "$date" > $advent_file
        fi
    fi

    epiphany_date=$next_year-01-06
    epiphany=`date -d "$epiphany_date" +%s`
    now=`date -d "$date" +%s`
    if [ $now -gt $epiphany ]; then
        # christmas is gone. remove the advent file
        rm $advent_file
    fi

    if [ ! -f $advent_file ]; then
        treefetch -bonsai
    else
        advent_text=`cat $advent_file`
        advent=`date -d "$advent_text" +%s`
        if [ $now -ge $advent -a $now -le $epiphany ]; then
            treefetch -xmas
        else
            treefetch -bonsai
        fi
    fi

}

# Use lf to switch directories and bind it to ctrl-o
# Source: https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52
lfcd () {
    if [ ! -d "$HOME/bin" ]; then
        mkdir -p $HOME/bin
    fi
    
    if [ ! -f "$HOME/bin/lf" ]; then
        BASEDIR=`pwd`
        cd $HOME/bin

        file=lf-linux-amd64.tar.gz
        if [ "$OS" = "Darwin" ]; then
            file=lf-darwin-amd64.tar.gz
        fi 

        wget https://github.com/gokcehan/lf/releases/download/r14/$file
        tar -zxvf $file
        rm $file
        mkdir -p ~/.config/lf
        curl https://raw.githubusercontent.com/gokcehan/lf/master/etc/lfrc.example -o ~/.config/lf/lfrc
        cd $BASEDIR
    fi

    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# For some themes which cursor is underline, when exit vim the cursor becomes a box. This function
# fix this error
_fix_cursor() {
  echo -ne '\e[3 q'
}
precmd_functions+=(_fix_cursor)

pipe(){
    if ! which pipes.sh &> /dev/null; then
        echo "Instalando pipes.sh"
        git clone https://github.com/pipeseroni/pipes.sh.git ~/.pipes.sh
        temp=$PWD
        cd ~/.pipes.sh
        make install
        cd $temp
    fi

    pipes.sh -t 3 -f 20
    clear

}

login() {
    if ! which bw &> /dev/null; then
        echo "client bitwarden não instalado. favor instalar:"
        echo "# $INSTALL bw"
    else
        bw logout --quiet
        export BW_SESSION=$(bw login | grep "export BW_SESSION" | sed -e "s/^\$\s\+export\s\+BW_SESSION=//g")
    fi
}

bump_mvn_version(){
    $PWD/mvnw versions:set -DnewVersion=$1
    $PWD/mvnw versions:commit
}

#FUNCTIONS per OS
[ -f "$HOME/.functions" ] && source "$HOME/.functions" &>/dev/null

##
# ALIASES
##

# General Aliases
alias tmux='tmux -u2'
alias ..='cd ..'
alias la='ls -la'
alias ll='ls -l'
alias clima='curl v2.wttr.in'
alias keygen='ssh-keygen -b 4096 -t rsa'
alias ps='ps aux'
alias f5='source $HOME/.zshrc'
alias tetris='tetriscurses'
alias bye='sudo shutdown -h now'
alias cal='cal -3'

# ALIASES per OS
[ -f "$HOME/.aliases" ] && source "$HOME/.aliases" &>/dev/null

##
# EXPORTS
##

# General exports
export NODE_ENV="development"
export PATH="$HOME/.cargo/bin:$HOME/bin:$PATH"
export EDITOR=vim
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"

#EXPORTS per OS
[ -f "$HOME/.exports" ] && source "$HOME/.exports" &>/dev/null

##
# OTHER USEFUL STUFF... OR NOT...
##

flag_file="/tmp/flag_file"
if [ ! -f $flag_file ]
then
  command -v fetch >/dev/null 2>&1 && { fetch; echo ; touch $flag_file ; }
  # only works if informant is installed (installed via AUR)
  command -v informant > /dev/null 2>&1 && { informant list --unread; echo; }
fi

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
fpath+=${ZDOTDIR:-~}/.zsh_functions
