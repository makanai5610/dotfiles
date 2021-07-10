#!/bin/bash

dotfiles_dir=$(git rev-parse --show-toplevel)
source "$dotfiles_dir/util/docker.sh"
source "$dotfiles_dir/util/ghq.sh"
source "$dotfiles_dir/util/git.sh"
source "$dotfiles_dir/util/kubectl.sh"
source "$dotfiles_dir/util/launch_app.sh"
source "$dotfiles_dir/util/memo.sh"
source "$dotfiles_dir/util/navigation.sh"
source "$dotfiles_dir/util/package_manager.sh"

function lg() {
    la | grep "$1"
}

function ports() {
    if [ $# -eq 0 ]; then
        lsof -i -P
    elif [ $# -eq 1 ]; then
        lsof -i -P | grep "$1"
    else
        echo_failure 'argument number should be 1 or 0.\n'
    fi
}
