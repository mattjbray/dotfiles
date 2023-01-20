#====[ Antigen ]====

f="/usr/local/share/antigen/antigen.zsh"; [ -f "$f" ] && source "$f"
f="/opt/homebrew/share/antigen/antigen.zsh"; [ -f "$f" ] && source "$f"
f="/usr/share/zsh-antigen/antigen.zsh"; [ -f "$f" ] && source "$f"

antigen use oh-my-zsh

antigen bundle vi-mode
antigen bundle git
# antigen bundle docker
# antigen bundle docker-compose
# antigen bundle helm
# antigen bundle kubectl
# antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
# antigen bundle chisui/zsh-nix-shell

antigen theme robbyrussell

antigen apply

#====[/ Antigen ]====

export PATH="/usr/local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

#====[ FNM ]====
export PATH="$HOME/.fnm:$PATH"
eval "`fnm env`"

#====[ Nix ]====
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
    . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

#====[ Google Cloud SDK ]====
export CLOUDSDK_PYTHON="python3"
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

#====[ Rust / Cargo ]====
. "$HOME/.cargo/env"

#====[ FZF ]====
f="${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh; [ -f "$f" ] && source "$f"


# _l_ess with std_e_rr
function le() { COLUMNS=$COLUMNS "$@" 2>&1 | less -S }

# echo "PATH:"
# echo "$PATH" | sed 's/:/\n/g'
