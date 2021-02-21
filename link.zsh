#!/usr/local/bin/zsh

script_dir=$(
    if [ -n "$(readlink $0)" ]; then
        cd "$(dirname $(readlink $0))"
        pwd
    else
        cd "$(dirname $0)"
        pwd
    fi
)

filepathes=(
    "/git"
    "/vim"
    ""
)

filenames=(
    ".gitconfig"
    ".vimrc"
    ".zshrc"
)

if test $#filepathes -ne $#filenames; then
    echo "filepathes count is not equal filenames count"
    echo "filepathes=$#filepathes, filenames=$#filenames"
fi

for i in $(seq 1 $#filepathes); do
    echo "$HOME/${filenames[$i]} -> $script_dir/${filepathes[$i]}/${filenames[$i]}"
    ln -si "$script_dir/${filepathes[$i]}/${filenames[$i]}" "$HOME"
done
