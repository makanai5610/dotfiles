#!/bin/zsh

script_dir=$(
    if [ -n "$(readlink $0)" ]; then
        cd "$(dirname $(readlink $0))"
        pwd
    else
        cd "$(dirname $0)"
        pwd
    fi
)

dry=""
if [ "$1" = "dry" ]; then
    dry="dry"
fi

$script_dir/cargo/install.zsh $dry
$script_dir/homebrew/install.zsh $dry
$script_dir/rustup/install.zsh $dry
