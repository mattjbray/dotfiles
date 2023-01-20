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

info "Installing NVM"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

info "Installing homebrew packages"
brew install \
     flyway \
     fswatch \
     fnm \
     helm \
     opam \
     postgres \
     slack \
     terraform \
     yq \
     homebrew/cask/docker \
     homebrew/cask/utm \
     adoptopenjdk/openjdk/adoptopenjdk11 \
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

info "Get credentials for GKE clusters"

# dev
gcloud container clusters --project imandra-dev get-credentials     --region europe-west1-c dev-imandra-web-cluster
gcloud container clusters --project imandra-dev get-credentials     --region europe-west1-c try-imandra-dev-cluster

kubectl config set-context dev-imandra-web  --cluster gke_imandra-dev_europe-west1-c_dev-imandra-web-cluster       --user gke_imandra-dev_europe-west1-c_dev-imandra-web-cluster
kubectl config set-context dev-try1         --cluster gke_imandra-dev_europe-west1-c_try-imandra-dev-cluster       --user gke_imandra-dev_europe-west1-c_try-imandra-dev-cluster       --namespace try1
kubectl config set-context dev-try2         --cluster gke_imandra-dev_europe-west1-c_try-imandra-dev-cluster       --user gke_imandra-dev_europe-west1-c_try-imandra-dev-cluster       --namespace try2
kubectl config set-context dev-core1        --cluster gke_imandra-dev_europe-west1-c_try-imandra-dev-cluster       --user gke_imandra-dev_europe-west1-c_try-imandra-dev-cluster       --namespace core1

# prod
gcloud container clusters --project imandra-prod get-credentials    --region europe-west1-c prod-imandra-web-cluster
gcloud container clusters --project imandra-prod get-credentials    --region europe-west1-c prod-tryimandra-try1-cluster
gcloud container clusters --project imandra-prod get-credentials    --region europe-west1-c prod-tryimandra-try2-cluster
gcloud container clusters --project imandra-prod get-credentials    --region europe-west1-c prod-imandracore-europe-west1-cluster
gcloud container clusters --project imandra-prod get-credentials    --region us-central1-c  prod-imandracore-us-central1-cluster

kubectl config set-context prod-imandra-web --cluster gke_imandra-prod_europe-west1-c_prod-imandra-web-cluster --user gke_imandra-prod_europe-west1-c_prod-imandra-web-cluster
kubectl config set-context prod-try1        --cluster gke_imandra-prod_europe-west1-c_prod-tryimandra-try1-cluster --user gke_imandra-prod_europe-west1-c_prod-tryimandra-try1-cluster
kubectl config set-context prod-core1       --cluster gke_imandra-prod_europe-west1-c_prod-tryimandra-try1-cluster --user gke_imandra-prod_europe-west1-c_prod-tryimandra-try1-cluster --namespace core1
kubectl config set-context prod-try2        --cluster gke_imandra-prod_europe-west1-c_prod-tryimandra-try2-cluster --user gke_imandra-prod_europe-west1-c_prod-tryimandra-try2-cluster
kubectl config set-context prod-core2       --cluster gke_imandra-prod_europe-west1-c_prod-tryimandra-try2-cluster --user gke_imandra-prod_europe-west1-c_prod-tryimandra-try2-cluster --namespace core2
kubectl config set-context prod-core-europe-west1     --cluster gke_imandra-prod_europe-west1-c_prod-imandracore-europe-west1-cluster --user gke_imandra-prod_europe-west1-c_prod-imandracore-europe-west1-cluster
kubectl config set-context prod-core-us-central1      --cluster gke_imandra-prod_us-central1-c_prod-imandracore-us-central1-cluster --user gke_imandra-prod_us-central1-c_prod-imandracore-us-central1-cluster

# gs-prod
gcloud container clusters --project imandra-gs-prod get-credentials --region europe-west2-a imandra-gs-prod-cluster

kubectl config set-context prod-gs       --cluster gke_imandra-gs-prod_europe-west2-a_imandra-gs-prod-cluster   --user gke_imandra-gs-prod_europe-west2-a_imandra-gs-prod-cluster
kubectl config set-context prod-gs-jm    --cluster gke_imandra-gs-prod_europe-west2-a_imandra-gs-prod-cluster   --user gke_imandra-gs-prod_europe-west2-a_imandra-gs-prod-cluster --namespace sigmax-job-manager

info "Install Imandra"
[ ! -f "/usr/local/bin/imandra" ] && \
    (sh <(curl -s "https://storage.googleapis.com/imandra-do/install.sh") || exit 1)
[ ! -f "$HOME/.imandra/login_token" ] && (imandra auth login || exit 1)
imandra core install || exit 1
