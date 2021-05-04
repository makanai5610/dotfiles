#!/bin/bash

file_names=(
    ".gitconfig"
    ".vimrc"
    ".p10k.zsh"
    ".zshrc"
    "move_word.json"
)

from_dir_pathes=(
    "/git"
    "/vim"
    "/p10k"
    "/zsh"
    "/karabiner"
)

to_dir_pathes=(
    "$HOME"
    "$HOME"
    "$HOME"
    "$HOME"
    "$HOME/.config/karabiner/assets/complex_modifications"
)

if [ ${#file_names[@]} != ${#from_dir_pathes[@]} ] || [ ${#from_dir_pathes[@]} != ${#to_dir_pathes[@]} ]; then
    echo_failure "file_names, from_dir_pathes and to_dir_pathes count is not equal each other."
    echo_failure "file_names=${#file_names[@]}, from_dir_pathes=${#from_dir_pathes[@]}, to_dir_pathes=${#to_dir_pathes[@]}"
    return 1
fi

for i in $(seq 0 $((${#file_names[@]} - 1))); do
    echo_success 'link '
    reset_style
    echo "${to_dir_pathes[$i]}/${file_names[$i]} -> $DOTFILES_PATH${from_dir_pathes[$i]}/${file_names[$i]}"
    ln -si "$DOTFILES_PATH${from_dir_pathes[$i]}/${file_names[$i]}" "${to_dir_pathes[$i]}"
done
