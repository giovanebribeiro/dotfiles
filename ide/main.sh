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

printSubsection "Tmux"
if which tmux &> /dev/null; then
  printSubSubsection "Tmux already installed"
else
  printSubSubsection "Installing Tmux"
  sudo $INSTALL tmux
fi

printSubSubsection "Updating tmux.conf"
if [ -f $HOME/.tmux.conf ]; then
  mv $HOME/.tmux.conf $HOME/tmux.conf.old
fi
ln -s $BASEDIR/tmux.conf $HOME/.tmux.conf

# Git configurations
printSubsection "Git configurations"

printSubSubsection "Update .gitconfig"
if [ -f $HOME/.gitconfig ]; then
  mv $HOME/.gitconfig $HOME/.gitconfig.old
fi
ln -s $BASEDIR/gitconfigs $HOME/.gitconfig

printSubSubsection "Update global gitignore"
if [ -f $HOME/.gitignore_global ]; then
  mv $HOME/.gitignore_global $HOME/.gitignore_global.old
fi
ln -s $BASEDIR/gitignore_global $HOME/.gitignore_global
git config --global core.excludesfile $HOME/.gitignore_global

if [ ! -f "$HOME/.git-completion.bash" ]; then
  printSubSubsection "Installing .git-completion.bash"
  curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o $HOME/.git-completion.bash
fi
printOK


# Todo.txt (task todo list manager which works offline and works on command line)

