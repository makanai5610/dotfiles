#!/bin/sh

script_dir=$(
    cd "$(dirname "$0")"
    pwd
)

install() {
    while read formula; do
        brew install "$formula"
    done <./formula.txt

    while read cask; do
        brew install "$cask"
    done <./cask.txt
}

dry_install() {
    while read formula; do
        echo "brew install $formula"
    done <"$script_dir/formula.txt"

    while read cask; do
        echo "brew install $cask"
    done <"$script_dir/cask.txt"
}

if [ "$1" = "dry" ]; then
    dry_install
else
    install
fi
