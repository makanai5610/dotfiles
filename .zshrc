#!/bin/zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

script_dir=$(
    if [ "$0" = "-zsh" -o "$0" = "zsh" -o "$0" = "/bin/zsh" ]; then
        cd "$(dirname $(readlink $HOME/.zshrc))"
        pwd
    elif [ -n "$(readlink $0)" ]; then
        cd "$(dirname $(readlink $0))"
        pwd
    else
        cd "$(dirname $0)"
        pwd
    fi
)

source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh"

source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc

source $script_dir/.zsh/alias.zsh
source $script_dir/.zsh/env.zsh
source $script_dir/.zsh/func.zsh
source $script_dir/colorize.zsh
