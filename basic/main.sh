OS=`uname`
BASEDIR=`dirname "$0"`
BASEDIR=$( cd $BASEDIR && pwd )
#teste
source "$PWD/common/util.sh"

printSection "Terminal files and general configurations (BASIC)"
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

if [ "$OS" == "Linux" ]; then
    printSubsection "Installing Powerline fonts"
    wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
    mv PowerlineSymbols.otf ~/.local/share/fonts/
    fc-cache -vf ~/.local/share/fonts/
    printSubsection "Installing Powerline fonts... OK (Please go to your terminal configurations and select the powerline fonts there)"
fi

if [ "$SHELL" -ne "/usr/bin/zsh" ];then
    sudo chsh -s /usr/bin/zsh $USER
fi

printSubsection "Installing zshrc..."
if [ -f "$HOME/.zshrc" ]; then
    rm $HOME/.zshrc
fi
ln -s $BASEDIR/zshrc $HOME/.zshrc

printSection "Terminal files and general configurations... OK"
