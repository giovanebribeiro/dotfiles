OS=`uname`
BASEDIR=`dirname "$0"`
BASEDIR=$( cd $BASEDIR && pwd )

source "$PWD/common/util.sh"

printSection "Terminal files and general configurations"
if [ ! -f "$HOME/.aliases" ]; then
  printSubsection "Installing aliases..."
  cp -v $BASEDIR/aliases_$OS.sh $HOME/.aliases
fi

if [ ! -f "$HOME/.exports" ]; then
  printSubsection "Installing exports..."
  cp -v $BASEDIR/exports_$OS.sh $HOME/.exports
fi

[ -e "$HOME/.Xresources" ] && rm $HOME/.Xresources
ln -s $BASEDIR/Xresources $HOME/.Xresources

printSubsection "Installing oh-my-zsh"
[ ! -d $HOME/.oh-my-zsh ] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

printSubsection "Installing theme"
if [ ! -d "$HOME/.oh-my-zsh/custom/themes" ]; then
    mkdir -p $ZSH_CUSTOM/themes
    
    if [ ! -d "$ZSH_CUSTOM/themes/typewritten" ]; then
        git clone https://github.com/reobin/typewritten.git $ZSH_CUSTOM/themes/typewritten
        ln -s "$ZSH_CUSTOM/themes/typewritten/typewritten.zsh-theme" "$ZSH_CUSTOM/themes/typewritten.zsh-theme"
    fi

fi

printSubsection "Installing zshrc..."
if [ -f "$HOME/.zshrc" ]; then
    rm $HOME/.zshrc
fi
ln -s $BASEDIR/zshrc $HOME/.zshrc

if [ "$OS" == "Linux" ]; then
    printSubsection "Installing Powerline fonts"
    wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
    mv PowerlineSymbols.otf ~/.local/share/fonts/
    fc-cache -vf ~/.local/share/fonts/
    printSubsection "Installing Powerline fonts... OK (Please go to your terminal configurations and select the powerline fonts there)"
fi

#case $OS in
#  "Darwin")
#    if [ -f "$HOME/.bash_profile" ]; then
#      printSubsection "Installing bash_profile..."
#      mv $HOME/.bash_profile $HOME/.bash_profile.old
#      ln -s $BASEDIR/bashrc $HOME/.bash_profile
#      source $HOME/.bash_profile
#    else
#      ln -s $BASEDIR/bashrc $HOME/.bash_profile
#      source $HOME/.bash_profile
#    fi	
#    ;;
#  "Linux")
#    if [ -f "$HOME/.bashrc" ]; then
#      printSubsection "Installing bashrc"
#      mv $HOME/.bashrc $HOME/.bashrc.old
#      ln -s $BASEDIR/bashrc $HOME/.bashrc
#      source $HOME/.bashrc
#    else
#      ln -s $BASEDIR/bashrc $HOME/.bashrc
#      source $HOME/.bashrc
#    fi	
#
#    printSubsection "Installing Powerline fonts"
#    wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
#    mv PowerlineSymbols.otf ~/.local/share/fonts/
#    fc-cache -vf ~/.local/share/fonts/
#    printSubsection "Installing Powerline fonts... OK (Please go to your terminal configurations and select the powerline fonts there)"
#    
#    ;;
#  "*")
#    printError "Unknown OS"
#    ;;
#esac
printSection "Terminal files and general configurations... OK"
