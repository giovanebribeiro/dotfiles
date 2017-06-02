source $PWD/common/util.sh

BASEDIR=`dirname "$0"`
BASEDIR=$( cd $BASEDIR && pwd )
INSTALL=$(cat $CMD_FILE)

printSection "Integrated Development Environment"

printSubsection "VIM"
if which vim &> /dev/null; then
  printSubSubsection "VIM already installed"
else
  sudo $INSTALL vim
  printSubSubsection "VIM installed successfully"
fi

printSubSubsection "Updating .vimrc"
if [ -f $HOME/.vimrc ]; then
  mv $HOME/.vimrc $HOME/.vimrc.old
fi
ln -s $BASEDIR/vimrc $HOME/.vimrc

if [ ! -d $HOME/.vim/bundle ]; then
  printSubSubsection "Installing plugins"
  mkdir -p $HOME/.vim/bundle
  git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
else
  printSubSubsection "Updating plugins"
fi
vim +PluginInstall +qall

printSubsection "TMUX"
if which tmux &> /dev/null; then
  printSubSubsection "Tmux already installed"
else
  sudo $INSTALL tmux
fi

printSubSubsection "Updating tmux.conf"
if [ -f $HOME/.tmux.conf ]; then
  mv $HOME/.tmux.conf $HOME/tmux.conf.old
fi
ln -s $BASEDIR/tmux.conf $HOME/.tmux.conf

# Git configurations
printSubSubSection "Update git configurations"

# Todo.txt (task todo list manager which works offline and works on command line)

printSection "Integrated Development Environment.. OK"
