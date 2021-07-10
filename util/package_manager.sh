#!/bin/bash

function update_all() {
    case "${OSTYPE}" in
    darwin*)
        brew upgrade
        brew autoremove
        brew cleanup
        pushd $DOTFILES_PATH/homebrew >/dev/null
        brew bundle install --cleanup --no-lock
        popd >/dev/null
        ;;
    linux*)
        sudo apt update
        sudo apt upgrade
        sudo apt autoremove
        sudo apt clean
        ;;
    esac

    rustup update
    ghq_fetch
    ghq_update
}

function link_dotfiles() {
    "$DOTFILES_PATH/link.sh"
}

function sync_brewfile() {
    pushd $DOTFILES_PATH/homebrew >/dev/null
    mv Brewfile Brewfile.before
    brew bundle dump
    mv Brewfile Brewfile.dumped
    /bin/cat Brewfile.before Brewfile.dumped | sort | uniq >Brewfile
    rm Brewfile.before Brewfile.dumped
    popd >/dev/null
}
