# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="mattjbray"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
  bundler
  fabric
  gem
  git
  heroku
  node
  npm
  pip
  python
  rails
  rails3
  rails4
  rake
  rsync
  ruby
  rvm
  tmux
  tmuxinator
  vagrant
  vi-mode
  virtualenv
  vundle
  )

# Load RVM into a shell session *as a function*
# Do this before sourcing oh-my-zsh
# (see https://github.com/robbyrussell/oh-my-zsh/pull/2107)
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# Set xterm-256color
if [[ -n "$DISPLAY" && "$TERM" == "xterm" ]]; then
  export TERM=xterm-256color
fi

# Prioritize /usr/local/bin
export PATH=/usr/local/bin:$PATH

export PATH=$HOME/.local/bin:$PATH
export EDITOR=vim

#
# Key bindings
#

# Bind reverse history search to C-R
bindkey "^R" history-incremental-search-backward

# C-e in insert mode jumps to end of line
bindkey "^E" end-of-line

# Vi mode: allow deletion past insertion point
zle -A .backward-kill-word   vi-backward-kill-word
zle -A .backward-delete-char vi-backward-delete-char

#
# Aliases
#

# Alias for git dotfiles repository
alias git-dotfiles="git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"

#
# RVM
#

# Add RVM to PATH for scripting
export PATH=$HOME/.rvm/bin:$PATH

# tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# Add npm installed binaries to PATH
export PATH=/usr/local/share/npm/bin:$PATH

# Optimor stuff

# Activate bmvenv
alias bmvenv="source ~/bmvenv/bin/activate && export PYTHONPATH=/home/mattjbray/dev/optimor/billmonitor:/home/mattjbray/dev/optimor/billmonitor/backend"

alias enable_incontract='DEBUG_ENV=production backend/script/debug/bmfeature -a in-contract'
alias set_crawl='DEBUG_ENV=production backend/script/debug/set_state.py --to=crawl --production'
alias set_parse='DEBUG_ENV=production backend/script/debug/set_state.py --to=parse --production'
alias set_idle='DEBUG_ENV=production backend/script/debug/set_state.py --to=retrieve.Idle --production'
alias force_plan_analysis='DEBUG_ENV=production backend/script/debug/set_state.py --parse --checked --production'
alias crawl_locally='backend/script/debug/crawl_locally.py --production -vc1'
alias crawl_test='backend/script/debug/crawl_all.py --production -v -c10'
alias crawl_all='backend/script/debug/crawl_all.py --production -v'
alias parse_locally='backend/script/debug/parse_locally.py --production -v --save'
alias user_info='backend/script/debug/user_info.py --env=production'
alias deploy_backend='build/script/hotfix production deploy -b'
alias account_email='backend/script/debug/find_accounts.py --production --email'
alias account_phone='backend/script/debug/find_accounts.py --production --phone'
#alias test_framework="JARS=`echo /../crawlers/lib/*.jar | sed 's/ /:/g'`;jython -J-cp $JARS crawlers/python/tests/framework_tests.py"
alias fix_engine_failed="DEBUG_ENV=production backend/script/debug/engine_failed.py --fixall"
