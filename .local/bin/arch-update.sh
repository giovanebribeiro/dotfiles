#!/bin/bash

echo "## Upgrade system"
sudo pacman -Syu

echo "## Checking for updates on AUR packages"
#echo "## !!! SUSPENDED UNTIL FIXING INFECTED AUR PACKAGES !!! ##"
dir=$HOME/.aur

for file in $dir/*/ ; do
    filename=$(basename "$file")

    cd $dir/$filename
    git pull | grep "Already up to date" > /dev/null
    if [ "$?" == "0" ]; then
	    echo "* $filename... OK"
    else
        echo "* Inspect PKGINFO..."
        $EDITOR PKGINFO
        read -p "Install (Y/n)? " q
        q=${q:-Y}
        case $q in
            [Yy]* ) 
                makepkg -sirc
                echo "* $filename updated successfully."
                ;;
            [Nn]* )
                echo "* $filename skipped."
                ;;
        esac
    fi
    cd $dir
done


