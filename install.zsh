#!/bin/zsh

local script_dir=''
if [ -n "$(readlink $0)" ]; then
    script_dir="$(dirname $(readlink $0))"
else
    script_dir="$(dirname $0)"
fi
if [ -z "$script_dir" ]; then
    local message='script_dir is empty.'
    echo -e "\e[31m$message\e[m"
    return 1
fi

pushd "$script_dir" >/dev/null
local work_dir=$(git rev-parse --show-toplevel)
source "$work_dir/colorize.zsh"
$PWD/homebrew/install.zsh $1
$PWD/rustup/install.zsh $1
$PWD/cargo/install.zsh $1
popd >/dev/null
