source $PWD/__setup/util.sh

install(){

    printSection "BSPWM ENV INSTALLS AND CONFIGURATIONS"

    printSubsection "** Install packages"
    # urxvt = terminal emulator
    # rofi = application launcher
    # bspwm = window manager. Comes with:
    #   * sxhkd = hotkey daemon
    # polybar = status bar
    # vifm = file manager based on vim
    # dunst = notification daemon
    # compton = composition
    # nitrogen = wallpaper manager
    installPkg rxvt-unicode rofi bspwm vifm dunst

    printSubsection "Install polybar (status bar)"
    installPkg build-essential clang-7.0 cmake cmake-data pkg-config python3-sphinx libcairo2-dev \
        libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev \
        python3-xcbgen xcb-proto \
        libxcb-image0-dev \
        libxcb-ewmh-dev libxcb-icccm4-dev \
        libxcb-xkb-dev \
        libxcb-xrm-dev \
        libxcb-cursor-dev \
        libpulse-dev \
        libpulse-dev \
        i3-wm \
        libjsoncpp-dev \
        libmpdclient-dev \
        libcurl4-openssl-dev \
        libnl-genl-3-dev

    git clone https://github.com/polybar/polybar $HOME/bin/polybar

    installPkg nitrogen  

    printSubsubsection "*** Run nitrogen on your wallpaper folder to choose your image"

    stowit $PWD/bspwm/base

    printOK

}

uninstall(){
    echo "To be implemented"
}
