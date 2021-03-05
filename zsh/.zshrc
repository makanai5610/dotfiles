#!/bin/zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh"
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc

local script_dir=''
if [ "$0" = "-zsh" -o "$0" = "zsh" -o "$0" = "/bin/zsh" ]; then
    script_dir="$(dirname $(readlink $HOME/.zshrc))"
elif [ -n "$(readlink $0)" ]; then
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
source $work_dir/util/colorize.zsh

source $PWD/env.zsh
source $PWD/alias.zsh
source $PWD/func.zsh

popd >/dev/null
