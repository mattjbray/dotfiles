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
    read -r -n 1 -p "Will now open $1 [Y/n] " ans
    printf "\n"
    if [ "$ans" = "y" ]; then
        open "$1"
    fi
}

link-dotfile() {
    mkdir -pv "$HOME/$(dirname "$1")"
    ln -sfnv "$dotfiles_dir/$1" "$HOME/$1"
}

info "Setting key repeat rate"
defaults write NSGlobalDomain KeyRepeat -int 1

[ -f "/opt/homebrew/bin/brew" ] && eval "$(/opt/homebrew/bin/brew shellenv)"

info "Checking for homebrew"
command -v brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

info "Upgrading homebrew packages"
brew upgrade

info "Installing homebrew packages"
brew install \
     ag \
     antigen \
     cmake \
     coreutils \
     emacs \
     fzf \
     git \
     gnu-tar \
     gpg \
     graphviz \
     htop \
     ispell \
     jq \
     ncdu \
     parallel \
     python \
     shellcheck \
     tig \
     tmux \
     watch \
     zsh

info "Configuring fzf"
/opt/homebrew/opt/fzf/install --xdg --key-bindings --completion --no-update-rc

info "Install Rosetta"
/usr/sbin/softwareupdate --install-rosetta --agree-to-license

info "Installing homebrew casks"
brew install \
     bitwarden \
     contexts \
     firefox \
     google-chrome \
     iterm2 \
     keybase \
     rectangle \
     spotify \
     visual-studio-code

if [ ! -d "$powerline_fonts_dir" ]; then
    info "Installing powerline fonts"
    git clone https://github.com/powerline/fonts.git --depth=1 "$powerline_fonts_dir"
    (cd "$powerline_fonts_dir"; ./install.sh)
fi

open-app /Applications/Bitwarden.app

open-app /Applications/Keybase.app

read -r -n 1 -p "Logged in to Keybase? Ready to export PGP keys to local gpg? [Y/n] " ans
printf "\n"
if [ "$ans" = "y" ]; then
    keybase pgp export | gpg --import
fi

# Configure iterm2
# Profile settings are in Library/Application Support/iTerm2/DynamicProfiles/mattjbray.json
# Haven't figured out how to set that as the default profile yet.
defaults write com.googlecode.iterm2 AllowClipboardAccess 1

open-app /Applications/Spectacle.app

# Configure Contexts
defaults write com.contextsformac.Contexts CTAppearanceTheme CTAppearanceNamedVibrantDark
defaults write com.contextsformac.Contexts CTPreferenceSidebarDisplayMode CTDisplayModeNone

open-app /Applications/Contexts.app

printf "Now install your contexts licence.\n"

if [ ! -f "$HOME/.ssh/id_rsa.pub" ]; then
    ssh-keygen
fi

< "$HOME/.ssh/id_rsa.pub" pbcopy
info "Your SSH pubkey has been copied to the clipboard."
open-app https://github.com/settings/ssh/new

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

link-dotfile ".local/bin/provision.sh"
link-dotfile ".spacemacs.d"
link-dotfile ".tmux.conf"
link-dotfile ".zshrc"
link-dotfile ".zshenv"
link-dotfile "Library/Application Support/iTerm2/DynamicProfiles/mattjbray.json"

info "All done!"
