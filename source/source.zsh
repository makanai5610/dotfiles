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

source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f "$script_dir/../p10k/.p10k.zsh" ]] || source "$script_dir/../p10k/.p10k.zsh"

source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc

source "$script_dir/alias.zsh"
source "$script_dir/env.zsh"
source "$script_dir/func.zsh"
