#!/usr/local/bin/zsh

function install() {
    if [ "$1" = 'dry' ]; then
        while read formula; do
            echo "brew install $formula"
        done <"$PWD/formula.txt"
        while read cask; do
            echo "brew install $cask"
        done <"$PWD/cask.txt"
    else
        while read formula; do
            brew install "$formula"
        done <"$PWD/formula.txt"
        while read cask; do
            brew install "$cask"
        done <"$PWD/cask.txt"
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
install $1

popd
