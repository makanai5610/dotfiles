#!/bin/sh

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
    done <./formula.txt

    while read cask; do
        echo "brew install $cask"
    done <./cask.txt
}

if [ "$1" = "dry" ]; then
    dry_install
else
    install
fi
