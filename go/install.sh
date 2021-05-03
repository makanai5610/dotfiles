#!/bin/bash

function install() {
    if [ "$1" = 'dry' ]; then
        while read package; do
            echo "go install $package@latest"
        done <$DOTFILES_PATH/go/package.txt
    else
        while read package; do
            go install "$package@latest"
        done <$DOTFILES_PATH/go/package.txt
    fi
}

# if $1 is 'dry', dry run.
install $1
