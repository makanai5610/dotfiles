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
    while read package; do
        cargo install "$package"
    done <"$script_dir/package.txt"
}

dry_install() {
    while read package; do
        echo "cargo install $package"
    done <"$script_dir/package.txt"
}

if [ "$1" = "dry" ]; then
    dry_install
else
    curl https://sh.rustup.rs -sSf | sh
    install
fi
