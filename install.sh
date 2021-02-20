#!/bin/sh

dry=""

if [ "$1" = "dry" ]; then
    dry="dry"
fi

scripts=(
    ./cargo/install.sh
    ./homebrew/install.sh
    ./rustup/install.sh
)
for script in "${scripts[@]}"; do
    $script $dry
done
