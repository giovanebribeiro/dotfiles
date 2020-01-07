BASEDIR=`dirname "$0"`
BASEDIR=$( cd $BASEDIR && pwd )

source "$PWD/common/util.sh"

printSection "Terminal files and general configurations (OTHER)"

printSubsection "Installing oh-my-zsh"
[ ! -d $HOME/.oh-my-zsh ] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"

# We must do this again because oh-my-zsh overwrites our zshrc.
if [ -f "$HOME/.zshrc" ]; then
    rm $HOME/.zshrc
fi

ln -s $BASEDIR/zshrc $HOME/.zshrc
printSubsection "Installing typewritten theme for zsh"
if [ ! -d "$ZSH_CUSTOM/themes/typewritten" ]; then
    git clone https://github.com/reobin/typewritten.git $ZSH_CUSTOM/themes/typewritten
    ln -s "$ZSH_CUSTOM/themes/typewritten/typewritten.zsh-theme" "$ZSH_CUSTOM/themes/typewritten.zsh-theme"
fi

installPkg neofetch cmatrix redshift-gtk
