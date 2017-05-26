#!/bin/bash

#ping -c 3 "google.com" &> output.log &
#pid=$!
#progress "installing:" $pid

sh ./prepare.sh

RET=`cat $PWD/tmp_pkg`

echo "Chosen package manager $RET"

rm "$PWD/tmp_pkg"
