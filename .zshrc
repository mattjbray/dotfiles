source "$HOME/antigen.zsh"

antigen use oh-my-zsh

antigen bundle vi-mode
antigen bundle git
antigen bundle docker
antigen bundle docker-compose
antigen bundle helm
antigen bundle kubectl
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle chisui/zsh-nix-shell

antigen theme blinks

antigen apply

# OPAM configuration
. /Users/mattjbray/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

if [ -f "$HOME/.nix-profile/etc/profile.d/nix/sh" ]; then
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi
