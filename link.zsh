#!/bin/zsh

filepathes=(
    "/git"
    "/vim"
    "/p10k"
    ""
)

filenames=(
    ".gitconfig"
    ".vimrc"
    ".p10k.zsh"
    ".zshrc"
)

if test $#filepathes -ne $#filenames; then
    echo "filepathes count is not equal filenames count"
    echo "filepathes=$#filepathes, filenames=$#filenames"
fi

for i in $(seq 1 $#filepathes); do
    echo "$HOME/${filenames[$i]} -> $PWD${filepathes[$i]}/${filenames[$i]}"
    ln -si "$PWD${filepathes[$i]}/${filenames[$i]}" "$HOME"
done
