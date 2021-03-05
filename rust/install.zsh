#!/bin/zsh

function install_rustup() {
    if [ "$1" = 'dry' ]; then
        echo 'curl https://sh.rustup.rs -sSf | sh'
    else
        which rustup
        if [ "$$?" != 0 ]; then
            curl https://sh.rustup.rs -sSf | sh
        fi
    fi
}

function install() {
    if [ "$1" = "dry" ]; then
        while read component; do
            echo "rustup component add $component"
        done <"$PWD/component.txt"
        while read package; do
            echo "cargo install $package"
        done <"$PWD/package.txt"
    else
        while read component; do
            rustup component add "$component"
        done <"$PWD/component.txt"
        while read package; do
            cargo install "$package"
        done <"$PWD/package.txt"
    fi
}

local script_dir=''
if [ -n "$(readlink $0)" ]; then
    script_dir="$(dirname $(readlink $0))"
else
    script_dir="$(dirname $0)"
fi
if [ -z "$script_dir" ]; then
    echo_failure "script_dir is empty."
    return 1
fi

pushd "$script_dir" >/dev/null

# if $1 is 'dry', dry run.
install_rustup $1
install $1

popd >/dev/null
