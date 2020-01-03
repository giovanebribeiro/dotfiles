OS=`uname`
BASEDIR=`dirname "$0"`
BASEDIR=$( cd $BASEDIR && pwd )

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

printSubsection "Installing oh-my-zsh"
[ ! -d $HOME/.oh-my-zsh ] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

printSection "Terminal files and general configurations... OK"
