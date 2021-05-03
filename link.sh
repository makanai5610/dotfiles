#!/bin/bash

file_names=(
    ".gitconfig"
    ".vimrc"
    ".p10k.zsh"
    ".zshrc"
    "move_word.json"
)

from_file_pathes=(
    "/git"
    "/vim"
    "/p10k"
    "/zsh"
    "/karabiner"
)

to_file_pathes=(
    "$HOME"
    "$HOME"
    "$HOME"
    "$HOME"
    "$HOME/.config/karabiner/assets/complex_modifications"
)

if [ $#file_names != $#from_file_pathes -o $#from_file_pathes != $#to_file_pathes ]; then
    echo_failure "file_names, from_file_pathes and to_file_pathes count is not equal each other."
    echo_failure "file_names=$#file_names, from_file_pathes=$#from_file_pathes, to_file_pathes=$#to_file_pathes"
    return 1
fi

for i in $(seq 1 $#from_file_pathes); do
    echo_success 'link '
    reset_style
    echo "${to_file_pathes[$i]}/${file_names[$i]} -> $DOTFILES_PATH${from_file_pathes[$i]}/${file_names[$i]}"
    ln -si "$DOTFILES_PATH${from_file_pathes[$i]}/${file_names[$i]}" "${to_file_pathes[$i]}"
done
