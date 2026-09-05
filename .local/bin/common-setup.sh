#!/bin/bash

#
# VIm plugins
#
[ ! -d $HOME/.vim/sessions ] && mkdir -p $HOME/.vim/sessions
[ ! -d $HOME/.vim/bundle ] && mkdir -p $HOME/.vim/bundle
[ ! -d $HOME/.vim/bundle/Vundle.vim ] && git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim/
vim +PluginInstall +qall
echo "* Install Vundle (vim plugin) and install vim plugins...................(OK)"

#
# rclone backup
#
gpg -o $HOME/.config/rclone/rclone.conf.bkp -d $HOME/.config/rclone/rclone.conf
echo "* Restore rclone backup (first, import the correct GPG key).............(OK)"

#
# Install shell improvements
#
# Zoxide (a better cd command)
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
# Atuin (upgraded shell history)
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
# sesh smart tmux session manager
go install github.com/joshmedeski/sesh/v2@latest
# fabric - an unique way to call llms from command line
curl -fsSL https://raw.githubusercontent.com/danielmiessler/fabric/main/scripts/installer/install.sh | bash
echo "* Install shell improvements............................................(OK)"


#
# Install other tools
#
git clone git@github.com:giovanebribeiro/pass.git
curl -fsSL https://raw.githubusercontent.com/bjarneo/cliamp/HEAD/install.sh | sh
echo "* Install other tools...................................................(OK)"

#
# Dev Tools
#
if [ ! -f ~/.dev_host ]; then
    read -p "Should install dev tools? [y/N]: " dev
    dev="${dev:-N}"

    echo $dev > ~/.dev_host
fi

dev=$(cat ~/.dev_host)

if [ "$dev" != "N" ]; then

    nvm install 22

    # Claude setup
    git clone git@github.com:giovanebribeiro/claude-setup.git ~/.claude
    npm install -g @anthropic-ai/claude-code
    uv tool install --python 3.13 posting --with requests
    # rtk (https://github.com/rtk-ai/rtk)
    curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh
    # serena (claude)
    uv tool install -p 3.13 serena-agent@latest --prerelease=allow
    claude mcp add --scope user serena -- serena start-mcp-server --context claude-code --project-from-cwd

    #echo "Install frameworks"
    #sdk install java
    #sdk install maven
    
    curl -sSfL https://golangci-lint.run/install.sh | sh -s -- -b $(go env GOPATH)/bin v2.9.0

    echo "Install kind"
    # For AMD64 / x86_64
    [ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.31.0/kind-linux-amd64
    # For ARM64
    [ $(uname -m) = aarch64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.31.0/kind-linux-arm64
    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind
fi

echo "Common setup............................................................(OK)"
echo "!!! OBS: Finish fabric configuration pointing to your llm provider api !!!"
echo "!!!!!!!!!!!!!!!!!!!!!! e.g. $ fabric --setup !!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
