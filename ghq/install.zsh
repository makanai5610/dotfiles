#!/usr/local/bin/zsh

function install() {
    if [ "$1" = 'dry' ]; then
        while read repo; do
            echo "ghq get https://$repo.git"
        done <$DOTFILES_PATH/ghq/repo.txt
    else
        while read repo; do
            ghq get "https://$repo.git"
        done <$DOTFILES_PATH/ghq/repo.txt
    fi
}

# if $1 is 'dry', dry run.
install $1
