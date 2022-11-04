#!/bin/bash

dir=$HOME/aur

for file in $dir/*/ ; do
    filename=$(basename "$file")
    echo "update $filename"

    cd $dir/$filename
    git pull
    makepkg -si --needed
    echo "update $filename finalizado com sucesso."
    cd $dir
done
