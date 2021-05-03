#!/bin/bash

function install() {
    if [ "$1" = 'dry' ]; then
        /bin/cat Brewfile
    else
        brew bundle --no-lock --force
    fi
}

pushd $DOTFILES_PATH/homebrew >/dev/null
install $1
popd >/dev/null
