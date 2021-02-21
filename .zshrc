#!/bin/zsh

zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

script_dir=$(
    if [ -n "-zsh" ]; then
        cd "$(dirname $(readlink $HOME/.zshrc))"
        pwd
    elif [ -n "$(readlink $0)" ]; then
        echo "b"
        cd "$(dirname $(readlink $0))"
        pwd
    else
        echo "c"
        cd "$(dirname $0)"
        pwd
    fi
)

$script_dir/source/source.zsh
