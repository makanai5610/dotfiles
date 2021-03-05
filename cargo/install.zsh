#!/bin/zsh

function install() {
    if [ "$1" = "dry" ]; then
        while read package; do
            echo "cargo install $package"
        done <"$PWD/package.txt"
    else
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
install
popd
