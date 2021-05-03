#!/bin/bash

function install() {
    if [ "$1" = 'dry' ]; then
        while read formula; do
            echo "brew install $formula"
        done <$DOTFILES_PATH/homebrew/formula.txt
    else
        while read formula; do
            brew install "$formula"
        done <$DOTFILES_PATH/homebrew/formula.txt
    fi
}

# if $1 is 'dry', dry run.
install $1
