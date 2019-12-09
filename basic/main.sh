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

case $OS in
  "Darwin")
    if [ -f "$HOME/.bash_profile" ]; then
      printSubsection "Installing bash_profile..."
      mv $HOME/.bash_profile $HOME/.bash_profile.old
      ln -s $BASEDIR/bashrc $HOME/.bash_profile
      source $HOME/.bash_profile
    else
      ln -s $BASEDIR/bashrc $HOME/.bash_profile
      source $HOME/.bash_profile
    fi	
    ;;
  "Linux")
    if [ -f "$HOME/.bashrc" ]; then
      printSubsection "Installing bashrc"
      mv $HOME/.bashrc $HOME/.bashrc.old
      ln -s $BASEDIR/bashrc $HOME/.bashrc
      source $HOME/.bashrc
    else
      ln -s $BASEDIR/bashrc $HOME/.bashrc
      source $HOME/.bashrc
    fi	

    printSubsection "Installing Powerline fonts"
    wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
    mv PowerlineSymbols.otf ~/.local/share/fonts/
    fc-cache -vf ~/.local/share/fonts/
    printSubsection "Installing Powerline fonts... OK (Please go to your terminal configurations and select the powerline fonts there)"
    
    ;;
  "*")
    printError "Unknown OS"
    ;;
esac
printSection "Terminal files and general configurations... OK"
