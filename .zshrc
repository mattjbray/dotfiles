f="/usr/local/share/antigen/antigen.zsh"; [ -f "$f" ] && source "$f"
f="/opt/homebrew/share/antigen/antigen.zsh"; [ -f "$f" ] && source "$f"
f="/usr/share/zsh-antigen/antigen.zsh"; [ -f "$f" ] && source "$f"

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

f="$HOME/.opam/opam-init/init.zsh"; [ -f "$f" ] && source "$f"

f="$HOME/.nix-profile/etc/profile.d/nix.sh"; [ -f "$f" ] && source "$f"

f="${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh; [ -f "$f" ] && source "$f"

alias lessrf=less -R +F

export CLOUDSDK_PYTHON="python3"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/mattjbray/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/mattjbray/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/mattjbray/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/mattjbray/google-cloud-sdk/completion.zsh.inc'; fi

# _l_ess with std_e_rr
function le() { "$@" 2>&1 | less -S }
