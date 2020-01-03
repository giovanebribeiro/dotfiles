BASEDIR=`dirname "$0"`
BASEDIR=$( cd $BASEDIR && pwd )

source "$PWD/common/util.sh"

printSection "Terminal files and general configurations (OTHER)"

printSubsection "Installing theme"
if [ ! -d "$HOME/.oh-my-zsh/custom/themes" ]; then
    mkdir -p $HOME/.oh-my-zsh/custom/themes
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/themes/typewritten" ]; then
    git clone https://github.com/reobin/typewritten.git $ZSH_CUSTOM/themes/typewritten
    ln -s "$HOME/.oh-my-zsh/custom/themes/typewritten/typewritten.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/typewritten.zsh-theme"
fi

printSubsection "Installing zshrc..."
if [ -f "$HOME/.zshrc" ]; then
    rm $HOME/.zshrc
fi
ln -s $BASEDIR/zshrc $HOME/.zshrc

if [ "$OS" == "Linux" ]; then
    printSubsection "Installing Powerline fonts"
    wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
    mv PowerlineSymbols.otf ~/.local/share/fonts/
    fc-cache -vf ~/.local/share/fonts/
    printSubsection "Installing Powerline fonts... OK (Please go to your terminal configurations and select the powerline fonts there)"
fi
