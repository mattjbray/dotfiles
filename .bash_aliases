alias s='screen'
alias git-dotfiles='git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'

_dir_chomp () {
    local IFS=/ c=1 n d
    local p=(${1/#$HOME/\~}) r=${p[*]}
    local s=${#r}
    while ((s>$2&&c<${#p[*]}-1))
    do
        d=${p[c]}
        n=1;[[ $d = .* ]]&&n=2
        ((s-=${#d}-n))
        p[c++]=${d:0:n}
    done
    echo "${p[*]}"
}

export EDITOR=/usr/bin/vim
export PATH=$PATH:$HOME/.local/bin

set -o vi
shopt -s cdspell
shopt -s checkwinsize

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# RVM bash completion
[[ -r "$HOME/.rvm/scripts/completion" ]] && source "$HOME/.rvm/scripts/completion"
# RVM PS1 functions
[[ -s "$HOME/.rvm/contrib/ps1_functions" ]] && source "$HOME/.rvm/contrib/ps1_functions"

source /usr/share/git/git-prompt.sh
export PS1='\u@\h:$(_dir_chomp "$(pwd)" 20)$(__git_ps1)$ '
PATH="/usr/local/heroku/bin:$PATH"
