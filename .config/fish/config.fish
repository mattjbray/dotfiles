# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Theme
set fish_theme robbyrussell

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Example format: set fish_plugins autojump bundler
set fish_plugins bundler rvm

# Path to your custom folder (default path is $FISH/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish cofiguration.
. $fish_path/oh-my-fish.fish


#
# Aliases
#

# Alias for git dotfiles repository
alias git-dotfiles="git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"

# Alias for screen
alias s="screen"
