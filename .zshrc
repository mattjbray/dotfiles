function source-if-exists() {
    [ -f "$1" ] && source "$1"
}

source-if-exists /usr/local/share/antigen/antigen.zsh
source-if-exists /usr/share/zsh-antigen/antigen.zsh

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

source-if-exists "$HOME/.opam/opam-init/init.zsh"

source-if-exists "$HOME/.nix-profile/etc/profile.d/nix.sh"

source-if-exists "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

source-if-exists '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source-if-exists '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

alias lessrf=less -R +F

export CLOUDSDK_PYTHON="python2"
