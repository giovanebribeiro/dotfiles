LOG_FILE=$HOME/dotfiles.log
CMD_FILE=/tmp/run_command

function printSection() { echo "# $1";  }
function printSubsection() { echo; echo "- $1"; echo;}
function printSubSubsection() { echo "* $1"; }
function printError() { echo "x $1"; }
function printOK() { echo; echo "...OK"; }
