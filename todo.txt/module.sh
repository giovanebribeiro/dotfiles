source $PWD/__setup/util.sh
DOTFILES_LOC=`cat $HOME/.dotfiles-loc`

install(){

    printSection "TODO.TXT"
    
    if [ ! -d $HOME/todo.txt ]; then
      printSubSubsection "Installing todo.txt"
      git clone https://github.com/ginatrapani/todo.txt-cli $HOME/todo.txt
      mv $HOME/todo.txt/todo.cfg $HOME/todo.txt/todo.cfg.old
    else
      printSubSubsection "Updating todo.txt"
      cd $HOME/todo.txt
      git pull
      cd $DOTFILES_LOC
    fi

    stowit $PWD/todo.txt/base
    aliasit "t" "'bash $HOME/todo.txt/todo.sh'"

    printOK

}

uninstall(){
    echo "To be implemented"
}
