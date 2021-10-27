#!/bin/bash

# set -ex

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
BOLD_YELLOW='\033[1;33m'
NC='\033[0m'

info() {
    printf "[${CYAN}$(basename $0)${NC}] $1\n"
}

xsudo() {
    info "sudo required for '$*'"
    sudo "$@"
}

open-app() {
    read -n 1 -p "Will now open $1 [Y/n] " ans
    printf "\n"
    if [ "$ans" = "y" ]; then
        open "$1"
    fi
}

info "Installing homebrew packages"
brew install \
     flyway \
     fswatch \
     node \
     opam \
     postgres \
     slack \
     yq \
     || exit 1

info "Init opam"
[ ! -d "$HOME/.opam" ] && (opam init || exit 1)

info "Cloning repos"

clone-ai-repo() {
    repo=$1
    [ ! -d "$HOME/code/ai/$repo" ] && \
        (git clone "git@github.com:aestheticintegration/$repo.git" \
            "$HOME/code/ai/$repo" \
            --recurse-submodules || exit 1)
}

clone-ai-repo imandra
clone-ai-repo imandra-web
clone-ai-repo sigmax
clone-ai-repo z3

info "Install Google Cloud SDK"
command -v gcloud || ( (curl https://sdk.cloud.google.com | bash && gcloud init) || exit 1 )

info "Install Imandra"
[ ! -f "/usr/local/bin/imandra" ] && \
    (sh <(curl -s "https://storage.googleapis.com/imandra-do/install.sh") || exit 1)
[ ! -f "$HOME/.imandra/login_token" ] && (imandra auth login || exit 1)
imandra core install || exit 1
