#!/bin/zsh

local zshrc_dir=''
if [ "$0" = "-zsh" -o "$0" = "zsh" -o "$0" = "/bin/zsh" ]; then
    zshrc_dir="$(dirname $(readlink $HOME/.zshrc))"
elif [ -n "$(readlink $0)" ]; then
    zshrc_dir="$(dirname $(readlink $0))"
else
    zshrc_dir="$(dirname $0)"
fi
if [ -z "$zshrc_dir" ]; then
    local message='zshrc_dir is empty.'
    echo -e "\e[31m$message\e[m"
    return 1
fi

pushd "$zshrc_dir" >/dev/null

local dotfiles_dir=$(git rev-parse --show-toplevel)

echo "source $dotfiles_dir/util/colorize.zsh"
source $dotfiles_dir/util/colorize.zsh
echo "source $dotfiles_dir/zsh/env.zsh"
source $dotfiles_dir/zsh/env.zsh
echo "source $dotfiles_dir/zsh/alias.zsh"
source $dotfiles_dir/zsh/alias.zsh
echo "source $dotfiles_dir/zsh/func.zsh"
source $dotfiles_dir/zsh/func.zsh

popd >/dev/null

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

source $GHQ_ROOT/github.com/romkatv/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh"
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

case "${OSTYPE}" in
    darwin*)
        source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
        source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
        ;;
esac
