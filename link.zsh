#!/bin/zsh

local file_names=(
    ".gitconfig"
    ".vimrc"
    ".p10k.zsh"
    ".zshrc"
    "move_word.json"
)

local from_file_pathes=(
    "/git"
    "/vim"
    "/p10k"
    ""
    "/karabiner"
)

local to_file_pathes=(
    "$HOME"
    "$HOME"
    "$HOME"
    "$HOME"
    "$HOME/.config/karabiner/assets/complex_modifications"
)

if [ $#file_names -ne $#from_file_pathes -o $#from_file_pathes -ne $#to_file_pathes ]; then
    echo "file_names, from_file_pathes and to_file_pathes count is not equal each other."
    echo "file_names=$#file_names, from_file_pathes=$#from_file_pathes, to_file_pathes=$#to_file_pathes"
    exit 1
fi

local work_dir=$(git rev-parse --show-toplevel)

for i in $(seq 1 $#from_file_pathes); do
    echo "${to_file_pathes[$i]}/${file_names[$i]} -> $work_dir${from_file_pathes[$i]}/${file_names[$i]}"
    ln -si "$work_dir${from_file_pathes[$i]}/${file_names[$i]}" "${to_file_pathes[$i]}"
done
