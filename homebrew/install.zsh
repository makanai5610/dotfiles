#!/usr/local/bin/zsh

script_dir=$(
    if [ -n "$(readlink $0)" ]; then
        cd "$(dirname $(readlink $0))"
        pwd
    else
        cd "$(dirname $0)"
        pwd
    fi
)

install() {
    while read formula; do
        brew install "$formula"
    done <"$script_dir/formula.txt"

    while read cask; do
        brew install "$cask"
    done <"$script_dir/cask.txt"
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
