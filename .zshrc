#====[ antigen ]====

  if [ ! -f "$HOME/.antigen/antigen.zsh" ]; then
    git clone https://github.com/zsh-users/antigen.git "$HOME/.antigen"
  fi

  source "$HOME/.antigen/antigen.zsh"

  antigen-use oh-my-zsh

  antigen-bundles <<EOBUNDLES
    brew
    osx
    rvm
    tmux
    vi-mode
    virtualenv
    vundle

    zsh-users/zsh-syntax-highlighting
    arialdomartini/oh-my-git
EOBUNDLES

  antigen theme arialdomartini/oh-my-git-themes arialdo-granzestyle

  antigen-apply

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

#====[ RVM ]====

  # Load RVM into a shell session *as a function*
  if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
    source "$HOME/.rvm/scripts/rvm"
  elif [[ -s "/etc/profile.d/rvm.sh" ]]; then
    source "/etc/profile.d/rvm.sh"
  fi

#====[ Optimor ]====

  # Activate bmvenv
  alias bmvenv='source ~/bmvenv/bin/activate \
    && export PYTHONPATH=`pwd`:`pwd`/backend'

  alias enable_incontract='DEBUG_ENV=production \
    backend/script/debug/bmfeature -a in-contract'

  alias set_crawl='DEBUG_ENV=production backend/script/debug/set_state.py \
    --to=crawl --production'

  alias set_parse='DEBUG_ENV=production backend/script/debug/set_state.py \
    --to=parse --production'

  alias set_idle='DEBUG_ENV=production backend/script/debug/set_state.py \
    --to=retrieve.Idle --production'

  alias force_plan_analysis='DEBUG_ENV=production \
    backend/script/debug/set_state.py --parse --checked --production'

  alias crawl_locally='backend/script/debug/crawl_locally.py --production -vc1'

  alias crawl_test='backend/script/debug/crawl_all.py --production -v -c10'

  alias crawl_all='backend/script/debug/crawl_all.py --production -v'

  alias parse_locally='backend/script/debug/parse_locally.py \
    --production -v --save'

  alias user_info='backend/script/debug/user_info.py --env=production'

  alias deploy_backend='build/script/hotfix production deploy -b'

  alias account_email='backend/script/debug/find_accounts.py \
    --production --email'

  alias account_phone='backend/script/debug/find_accounts.py \
    --production --phone'

  alias fix_engine_failed="DEBUG_ENV=production \
    backend/script/debug/engine_failed.py --fixall"

  grep_logs() {
    if (($1==frontend)); then
      subdir=''
    else
      subdir="$1/"
    fi
    servers=('bmstack01' 'bmstack02')
    for server in $servers; do
      echo "------------[  $server ]------------"
      ssh $server "sudo -u optimor grep -r $2 /var/releases/$1/current/${subdir}log"
      echo "------------[ /$server ]------------\n"
    done
  }

#====[ PATH ]====

  # Prioritize /usr/local/bin
  export PATH=/usr/local/bin:$PATH
