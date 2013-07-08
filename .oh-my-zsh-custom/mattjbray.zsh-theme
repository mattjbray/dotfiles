PROMPT='$ '

RPS1='$(vi_mode_prompt_info)%{$reset_color%} $(git_prompt_info) $(virtualenv_prompt_info)%{$reset_color%}$(rvm-prompt) %F{green}%~%f'

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%})%{$fg[yellow]%}+%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
