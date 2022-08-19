#!/bin/bash
#
# change_volume.sh
# Author: Giovane Boaviagem <giovane@boaviagemribeiro.com>
# 
# Inspired in arch linux change volume script (https://wiki.archlinux.org/title/Dunst)
#
# install: 
# # ln -s /path/to/change_volume.sh /usr/local/bin/change_volume
# usage: 
# $ change_volume "5%-"     # volume down
# $ change_volume "5%+"     # volume up
# $ change_volume "toggle"  # volume mute/unmute
# 
# Requirements:
# * dunst
# * pamixer

# Arbitrary but unique message tag
msgTag="gioz_change_volume"
# You need to change if you use pulseaudio
volumeCmd="pamixer"

# Change the volume using alsa(might differ if you use pulseaudio)
$volumeCmd "$@" > /dev/null

# Query amixer for the current volume and whether or not the speaker is muted
volume="$(pamixer --get-volume)"
mute="$(pamixer --get-mute)"
if [[ $volume == 0 || "$mute" == "true" ]]; then
    # Show the sound muted notification
    dunstify -a "changeVolume" -u low -i audio-volume-muted -h string:x-dunst-stack-tag:$msgTag "Volume muted" 
else
    # Show the volume notification
    dunstify -a "changeVolume" -u low -i audio-volume-high -h string:x-dunst-stack-tag:$msgTag \
    -h int:value:"$volume" "Volume: ${volume}%"
fi

# Play the volume changed sound
canberra-gtk-play -i audio-volume-change -d "changeVolume"
