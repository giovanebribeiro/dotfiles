#!/bin/bash

source util.sh

ping -c 3 "google.com" &> output.log &
pid=$!

progress "installing:" $pid
