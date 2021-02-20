#!/bin/sh

script_dir=$(
    cd "$(dirname $0)"
    pwd
)

install() {
    while read component; do
        rustup component add "$component"
    done <"$script_dir/component.txt"
}

dry_install() {
    while read component; do
        echo "rustup component add $component"
    done <"$script_dir/component.txt"
}

if [ "$1" = "dry" ]; then
    dry_install
else
    install
fi
