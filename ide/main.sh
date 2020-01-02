source $PWD/common/util.sh

BASEDIR=`dirname "$0"`
BASEDIR=$( cd $BASEDIR && pwd )
INSTALL=$(cat $CMD_FILE)

printSection "Integrated Development Environment"
echo $BASEDIR

# [ -z ${vim_executed} ] && basic
printSubsection "VIM"
if which vim.gtk &> /dev/null; then
printSubSubsection "VIM already installed"
else
OS=`uname`
case $OS in 
  "Darwin")
    $INSTALL macvim
    ;;
  "Linux")
    $INSTALL vim
    ;;
  "*")
    printError "Unknown OS"
    ;;
esac
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
    vim +PluginInstall +qall
else
    printSubSubsection "Updating plugins"
    vim +PluginUpdate +qall
fi
[ ! -d $HOME/.vim/sessions ] && mkdir -p $HOME/.vim/sessions

printSubSubsection "Install another plugins"
if [ ! -d $HOME/.vim/bundle/another_plugins ]; then
    cp -r $BASEDIR/plugin/ $HOME/.vim/bundle/
fi



printSubsection "Tmux"
if which tmux &> /dev/null; then
    printSubSubsection "Tmux already installed"
else
    printSubSubsection "Installing Tmux"
    $INSTALL tmux

    printSubSubsection "get tmux.conf"
    if [ -d $HOME/.tmux ]; then
      rm -rf $HOME/.tmux
    fi

    git clone https://github.com/gpakosz/.tmux $HOME/.tmux
    ln -s $HOME/.tmux/.tmux.conf $HOME/.tmux.conf
    ln -s $BASEDIR/tmux.conf.local $HOME/.tmux.conf.local

fi

printSubsection "Markdown"
$INSTALL markdown

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

printOK

printSubsection "Ctags"

if which ctags &> /dev/null; then
  printSubSubsection "Ctags already installed"
else
  printSubSubsection "Installing ctags"
  $INSTALL exuberant-ctags
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
  mkdir $HOME/.todo
else
  printSubSubsection "Updating todo.txt"
  cd $HOME/todo.txt
  rm $HOME/todo.txt/todo.cfg
  mv $HOME/todo.txt/todo.cfg.old $HOME/todo.txt/todo.cfg
  git pull
fi
mv $HOME/todo.txt/todo.cfg $HOME/todo.txt/todo.cfg.old
ln -s $BASEDIR/todo.cfg $HOME/todo.txt/todo.cfg
printOK
