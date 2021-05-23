#!/bin/bash

function link_zsh() {
    echo_success 'link '
    reset_style
    echo "$HOME/.zshrc -> $DOTFILES_PATH/zsh/.zshrc"
    ln -si "$DOTFILES_PATH/zsh/.zshrc" "$HOME"
}

function link_vim() {
    echo_success 'link '
    reset_style
    echo "$HOME/.vimrc -> $DOTFILES_PATH/vim/.vimrc"
    ln -si "$DOTFILES_PATH/vim/.vimrc" "$HOME"
}

function link_p10k() {
    echo_success 'link '
    reset_style
    echo "$HOME/.p10k.zsh -> $DOTFILES_PATH/p10k/.p10k.zsh"
    ln -si "$DOTFILES_PATH/p10k/.p10k.zsh" "$HOME"
}

function link_git() {
    if [ ! -d "$XDG_CONFIG_HOME" ]; then
        mkdir -p "$XDG_CONFIG_HOME"
    fi
    echo_success 'link '
    reset_style
    echo "$XDG_CONFIG_HOME/git -> $DOTFILES_PATH/git"
    ln -si "$DOTFILES_PATH/git" "$XDG_CONFIG_HOME"
}

function link_karabiner() {
    if [ ! -d "$XDG_CONFIG_HOME/karabiner/assets/complex_modifications" ]; then
        mkdir -p "$XDG_CONFIG_HOME/karabiner/assets/complex_modifications"
    fi
    echo_success 'link '
    reset_style
    echo "$XDG_CONFIG_HOME/karabiner/assets/complex_modifications/move_word.json -> $DOTFILES_PATH/karabiner/move_word.json"
    ln -si "$DOTFILES_PATH/karabiner/move_word.json" "$XDG_CONFIG_HOME/karabiner/assets/complex_modifications"
}

link_zsh
link_vim
link_p10k
link_git
link_karabiner
