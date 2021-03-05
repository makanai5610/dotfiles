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
    "/.zsh"
    "/karabiner"
)

local to_file_pathes=(
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

local script_dir=''
if [ -n "$(readlink $0)" ]; then
    script_dir="$(dirname $(readlink $0))"
else
    script_dir="$(dirname $0)"
fi
if [ -z "$script_dir" ]; then
    echo_failure "script_dir is empty."
    return 1
fi

pushd "$script_dir" >/dev/null

local work_dir=$(git rev-parse --show-toplevel)
source "$work_dir/util/colorize.zsh"

for i in $(seq 1 $#from_file_pathes); do
    echo_success 'link '
    reset_style
    echo "${to_file_pathes[$i]}/${file_names[$i]} -> $work_dir${from_file_pathes[$i]}/${file_names[$i]}"
    ln -si "$work_dir${from_file_pathes[$i]}/${file_names[$i]}" "${to_file_pathes[$i]}"
done

popd >/dev/null
