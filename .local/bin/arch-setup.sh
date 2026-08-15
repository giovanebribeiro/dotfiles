#!/bin/bash

## Remember: when you install Arch, in pacstrap phase, run the command with these initial packages, along the base ones.
## If you forget, you must install them before run this script.

# pacstrap -K /mnt base linux linux-firmware base-devel networkmanager gvim man-db man-pages texinfo ntfs-3g ntfsprogs sof-firmware alsa-firmware alsa-ucm-conf

## Install system packages
pacman -Syy alacritty cmake hyprland pipewire wireplumber \
    xdg-desktop-portal-hyprland hyprpolkitagent unzip pipewire-jack \
    ttf-input-nerd firefox docker docker-buildx docker-compose wget \
    the_silver_searcher tmux otf-font-awesome noto-fonts \
    ttf-liberation bash-preexec ninja meson cmake nlohmann-json \
    qt6-base ffmpeg layer-shell-qt pkg-config wl-clipboard \
    xdg-utils cliphist hyprlock vifm brightnessctl pamixer pipewire-pulse \
    pavucontrol bluez bluez-utils nerd-font hypridle zip go fzf cronie \
    obsidian blueman pwgen gnupg tree git xclip pass cups cups-pdf \
    hyprshutdown powerline-fonts rclone inter-font imagemagick emacs-nox 

echo "Enable docker"
sudo systemctl enable docker.service
YOUR_USER=$USER
sudo usermod -aG docker $YOUR_USER

echo "Enable hyprland plugins"
hyprpm update
hyprpm add https://github.com/gfhdhytghd/HyprCapture
hyprpm enable hyprcapture
hyprpm reload

echo "Enable some daemons"
sudo systemctl start bluetooth.service
sudo systemctl enable bluetooth.service
sudo systemctl start NetworkManager.service
sudo systemctl enable NetworkManager.service
sudo systemctl start cronie.service
sudo systemctl enable cronie.service
sudo systemctl start cups.service
sudo systemctl enable cups.service

echo "Install AUR packages"
BASEDIR=$PWD
AUR_PACKAGES=(bzmenu informant) # informant deve ser o último elemento do array.
[ ! -d $HOME/.aur ] && mkdir -p $HOME/.aur
for item in "${AUR_PACKAGES[@]}"; do
    echo "Install: $item"
    if [ ! -d $HOME/.aur/$item ]; then
        git clone https://aur.archlinux.org/$item.git $HOME/.aur/$item
    fi
    cd $HOME/.aur/$item
    makepkg -s -i -r -c
    sudo pacman -U *.zst
done
cd $BASEDIR

# install common stuff
common-setup.sh
