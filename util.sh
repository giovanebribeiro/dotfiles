LOG_FILE=$HOME/dotfiles.log
CMD_FILE=/tmp/run_command

function printSection() { echo "# $1"; }
function printSubsection() { echo "* $1"; }
function printError() { echo "x $1"; }
