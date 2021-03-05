#!/bin/zsh

function install() {
    if [ "$1" = "dry" ]; then
        while read component; do
            echo "rustup component add $component"
        done <"$PWD/component.txt"
    else
        while read component; do
            rustup component add "$component"
        done <"$PWD/component.txt"
    fi
}

if [ "$(
    which rustup
    $?
)" != 0 ]; then
    curl https://sh.rustup.rs -sSf | sh
fi

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
popd >/dev/null
