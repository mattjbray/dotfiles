source "$HOME/antigen.zsh"

antigen use oh-my-zsh

antigen bundle vi-mode
antigen bundle git
antigen bundle docker
antigen bundle docker-compose
antigen bundle helm
antigen bundle kubectl
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme blinks

antigen apply

# OPAM configuration
. /Users/mattjbray/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# The next line updates PATH for the Google Cloud SDK.
source '/Users/mattjbray/Downloads/google-cloud-sdk/path.zsh.inc'
