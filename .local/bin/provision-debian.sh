#!/bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
BOLD_YELLOW='\033[1;33m'
NC='\033[0m'

dotfiles_dir="$HOME/code/mattjbray/dotfiles"
powerline_fonts_dir="$HOME/code/powerline/fonts"

info() {
    printf "[${CYAN}provision.sh${NC}] $1\n"
}

xsudo() {
    info "sudo required for '$*'"
    sudo "$@"
}

open-app() {
    read -n 1 -p "Will now open $1 [Y/n] " ans
    printf "\n"
    if [ "$ans" = "y" ]; then
        open "$1"
    fi
}

link-dotfile() {
    mkdir -pv "$HOME/$(dirname "$1")"
    ln -sfnv "$dotfiles_dir/$1" "$HOME/$1"
}

info "Installing packages"
xsudo apt install \
     silversearcher-ag \
     zsh-antigen \
     emacs \
     fzf \
     git \
     jq \
     ncdu \
     shellcheck \
     tmux \
     watch \
     zsh

# info "Configuring fzf"
# /usr/local/opt/fzf/install --xdg --key-bindings --completion --no-update-rc

if ! dpkg -s keybase 2>/dev/null >/dev/null ; then
    info "Installing keybase"
    curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
    xsudo apt install ./keybase_amd64.deb && rm ./keybase_amd64.deb
    run_keybase -g
else
    info "Keybase is already installed"
fi

if [ ! -f "$HOME/.ssh/id_rsa.pub" ]; then
    ssh-keygen
fi

if [ ! -d "$dotfiles_dir" ]; then
    git clone git@github.com:mattjbray/dotfiles.git "$dotfiles_dir"
fi

info "Create xterm-24bit.terminfo"
/usr/bin/tic -x -o ~/.terminfo "${dotfiles_dir}/src/xterm-24bit.terminfo"

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

if [ ! -d "$HOME/.emacs.d" ]; then
    git clone https://github.com/syl20bnr/spacemacs "$HOME/.emacs.d" --branch develop
fi

info "Linking dotfiles"

link-dotfile ".local/bin/provision-debian.sh"
link-dotfile ".spacemacs.d"
link-dotfile ".tmux.conf"
link-dotfile ".zshrc"
link-dotfile ".zshenv"

if [ ! $(command -v opam) ]; then
    info "Install opam"
    bash -c "sh <(curl -fsSL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)"
fi

if [ ! -d "$HOME/.opam" ]; then
    info "Init opam"
    (opam init || exit 1)
fi

if [ ! $(command -v fnm) ]; then
    info "Install fnm (fast node manager)"
    curl -fsSL https://fnm.vercel.app/install | bash
fi

info "All done!"
