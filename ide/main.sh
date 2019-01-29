source $PWD/common/util.sh

BASEDIR=`dirname "$0"`
BASEDIR=$( cd $BASEDIR && pwd )
INSTALL=$(cat $CMD_FILE)

printSection "Integrated Development Environment"
echo $BASEDIR

printSubsection "VIM"
if which vim &> /dev/null; then
  printSubSubsection "VIM already installed"
else
  sudo $INSTALL vim
  printSubSubsection "VIM installed successfully"
fi

printSubSubsection "Updating .vimrc"
if [ -f $HOME/.vimrc ]; then
  rm $HOME/.vimrc
fi
ln -s $BASEDIR/vimrc $HOME/.vimrc

if [ ! -d $HOME/.vim/bundle ]; then
  printSubSubsection "Installing plugins"
  mkdir -p $HOME/.vim/bundle
  git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
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
  rm $HOME/.tmux.conf
fi
ln -s $BASEDIR/tmux.conf $HOME/.tmux.conf

# Git configurations
printSubsection "Git configurations"

printSubSubsection "Update .gitconfig"
if [ -f $HOME/.gitconfig ]; then
  rm $HOME/.gitconfig
fi
ln -s $BASEDIR/gitconfigs $HOME/.gitconfig

printSubSubsection "Update global gitignore"
if [ -f $HOME/.gitignore_global ]; then
  rm $HOME/.gitignore_global
fi
ln -s $BASEDIR/gitignore_global $HOME/.gitignore_global
git config --global core.excludesfile $HOME/.gitignore_global

if [ ! -f "$HOME/.git-completion.bash" ]; then
  printSubSubsection "Installing .git-completion.bash"
  curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o $HOME/.git-completion.bash
fi
printOK

printSubsection "Ctags"

if which ctags &> /dev/null; then
  printSubSubsection "Ctags already installed"
else
  printSubSubsection "Installing ctags"
  sudo $INSTALL exuberant-ctags
fi

printSubSubsection "Updating .ctags"
if [ -L $HOME/.ctags ]; then
  rm $HOME/.ctags
fi
ln -s $BASEDIR/ctags $HOME/.ctags

printOK

printSubsection "Todo.txt"

if [ ! -d $HOME/todo.txt ]; then
  printSubSubsection "Installing todo.txt"
  git clone https://github.com/ginatrapani/todo.txt-cli $HOME/todo.txt
else
  printSubSubsection "Updating todo.txt"
  rm $HOME/todo.txt/todo.cfg
  mv $HOME/todo.txt/todo.cfg.old $HOME/todo.txt/todo.cfg
  git pull
fi
mv $HOME/todo.txt/todo.cfg $HOME/todo.txt/todo.cfg.old
ln -s $BASEDIR/todo.cfg $HOME/todo.txt/todo.cfg
printOK
