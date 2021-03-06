source /usr/local/share/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle vi-mode
antigen bundle git
antigen bundle docker
antigen bundle docker-compose
antigen bundle helm
antigen bundle kubectl
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle chisui/zsh-nix-shell

antigen theme robbyrussell

antigen apply

# OPAM configuration
. /Users/mattjbray/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

if [ -f "$HOME/.nix-profile/etc/profile.d/nix/sh" ]; then
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

alias lessrf=less -R +F

export CLOUDSDK_PYTHON="python2"
