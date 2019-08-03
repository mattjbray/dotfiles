#!/bin/bash

set -e

dotfiles_dir="$HOME/code/mattjbray/dotfiles"
powerline_fonts_dir="$HOME/code/powerline/fonts"

function open-app() {
    read -n 1 -p "Will now open $1 [Y/n] " ans
    printf "\n"
    if [ "$ans" = "y" ]; then
        open "$1"
    fi
}

function link-dotfile() {
    mkdir -pv "$HOME/$(dirname "$1")"
    ln -sfnv "$dotfiles_dir/$1" "$HOME/$1"
}

command -v brew || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install \
     antigen \
     emacs \
     git \
     python \
     tmux \
     zsh

brew cask install \
     contexts \
     iterm2 \
     firefox \
     keybase \
     lastpass \
     spectacle

if [ ! -d "$powerline_fonts_dir" ]; then
    git clone https://github.com/powerline/fonts.git --depth=1 "$powerline_fonts_dir"
    (cd "$powerline_fonts_dir"; ./install.sh)
fi

open-app /Applications/LastPass.app
open-app /Applications/Keybase.app

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
printf "Your SSH pubkey has been copied to the clipboard.\n"
open-app https://github.com/settings/ssh/new

if [ ! -d "$dotfiles_dir" ]; then
    git clone git@github.com:mattjbray/dotfiles.git "$dotfiles_dir"
fi

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

if [ ! -d "$HOME/.emacs.d" ]; then
    git clone https://github.com/syl20bnr/spacemacs "$HOME/.emacs.d" --branch develop
fi

printf "Linking dotfiles...\n"

link-dotfile ".local/bin/provision.sh"
link-dotfile ".spacemacs.d"
link-dotfile ".tmux.conf"
link-dotfile "Library/Application Support/iTerm2/DynamicProfiles/mattjbray.json"

printf "All done!\n"
