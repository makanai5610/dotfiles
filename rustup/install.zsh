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
