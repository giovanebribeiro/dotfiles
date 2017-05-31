LOG_FILE=$HOME/dotfiles.log
CMD_FILE=/tmp/run_command

## Mount a progress bar (spin) to run while a command are being executed
## $1 = some message to print with the progress bar
## $2 = the PID of running command
function progress(){
  spin='-\|/'

  i=0
  while kill -0 $2 2> /dev/null
  do
    i=$(( (i+1) %4 ))
    printf "\r $1 ${spin:$i:1}"
    sleep .1
  done
}

## Run a command with a progress bar
## $1 = The command to run
## $2 = a message to print with the command execution
function run(){
  exe=$1
  
  $exe &> $LOG_FILE &
  pid=$!

  progress "Running command $exe:" $pid
}

function printSection() { echo "## $1"; }
function printSubsection() { echo "* $1"; }
function printError() { echo "x $1"; }
