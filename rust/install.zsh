#!/bin/zsh

function install_rustup() {
    if [ "$1" = 'dry' ]; then
        echo 'curl https://sh.rustup.rs -sSf | sh'
    else
        which rustup
        if [ "$?" != 0 ]; then
            curl https://sh.rustup.rs -sSf | sh
        fi
    fi
}

function install() {
    if [ "$1" = "dry" ]; then
        while read component; do
            echo "rustup component add $component"
        done <$DOTFILES_PATH/rust/component.txt
        while read package; do
            echo "cargo install $package"
        done <$DOTFILES_PATH/rust/package.txt
    else
        while read component; do
            rustup component add "$component"
        done <$DOTFILES_PATH/rust/component.txt
        while read package; do
            cargo install "$package"
        done <$DOTFILES_PATH/rust/package.txt
    fi
}

# if $1 is 'dry', dry run.
install_rustup $1
install $1
