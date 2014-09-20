#====[ prezto ]====

  if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
  fi

#====[ Functions ]====

  calc() { echo "$@" | bc -l ; }

#====[ Vim ]====

  export EDITOR=vim

  # c-e in insert mode jumps to end of line
  bindkey "^E" end-of-line

  # c-r in insert mode opens reverse history search
  bindkey "^R" history-incremental-search-backward

  # allow deletion past insertion point
  zle -A .backward-kill-word   vi-backward-kill-word
  zle -A .backward-delete-char vi-backward-delete-char

#====[ Alias for git dotfiles repository ]====

  alias git-dotfiles="git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"

#====[ Aliases ]====

  alias switch-wifi='sudo netctl-auto switch-to'

#====[ Optimor ]====

  export PATH_OPTIMOR='/opt/optimor'
  export PATH=$PATH_OPTIMOR/bin/inpath:$PATH

  bmenv() {
    tmux attach -t $1 || (export BMENV=$1 && cd /opt/optimor/src/billmonitor/$1 && tmux new-session -s $1)
  }

  bmvenv() {
    source /opt/optimor/bin/python_envs/$1/bin/activate
    export PYTHONPATH=`pwd`:`pwd`/backend
    export LD_LIBRARY_PATH=`pwd`/engine/cxx/lib
  }

  if [ -n "${BMENV+x}" ]; then
    bmvenv $BMENV
  fi

  alias cbenv='source /opt/optimor/src/ansible/venv/bin/activate && source /opt/optimor/src/ansible/hacking/env-setup'
  alias cookbooks='tmux attach-session -t cookbooks || (cd /opt/optimor/src/optimor-cookbooks && tmux new-session -s cookbooks)'

  alias bmdebug='tmux attach-session -t debug || (cd /opt/optimor/src/billmonitor/debug && tmux new-session -s debug)'
  alias bmfrontend='tmux attach-session -t frontend || (cd /opt/optimor/src/billmonitor-frontend/master && tmux new-session -s frontend)'
  alias tbackend='tmux attach-session -t theia-backend || (cd /opt/optimor/src/billmonitor/theia && tmux new-session -s theia-backend)'
  alias tfrontend='tmux attach-session -t theia-frontend || (cd /opt/optimor/src/theia-frontend/master && tmux new-session -s theia-frontend)'

  alias infab='cat doc/some_fabs.md | grep -iC 2'

#====[ PATH ]====

  export PATH=$HOME/.local/bin:$PATH
  export PATH=$HOME/.cabal/bin:$PATH

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
