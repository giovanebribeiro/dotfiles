source $PWD/util.sh

BASEDIR=`dirname "$0"`
BASEDIR=$( cd $BASEDIR && pwd )
INSTALL=$(cat $CMD_FILE)

printSection "Integrated Development Environment"

# VIM
if which vim &> /dev/null; then
  printSubsection "VIM already installed"
else
  $INSTALL vim
fi

if [ -f $HOME/.vimrc ]; then
  mv $HOME/.vimrc $HOME/.vimrc.old
fi
ln -s $BASEDIR/vimrc $HOME/.vimrc

if [ ! -f $HOME/.vim/bundle ]; then
  mkdir -p $HOME/.vim/bundle
  git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  vim +PluginInstall +qall
fi

# Tmux
if which tmux &> /dev/null; then
  printSubsection "Tmux already installed"
else
  $INSTALL tmux
fi

if [ -f $HOME/.tmux.conf ]; then
  mv $HOME/.tmux.conf $HOME/tmux.conf.old
fi
ln -s $BASEDIR/tmux.conf $HOME/.tmux.conf

# Git configurations

# Todo.txt (task todo list manager which works offline and works on command line)

printSection "Integrated Development Environment.. OK"
