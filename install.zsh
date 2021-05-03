#!/bin/zsh

# if $1 is 'dry', dry run.
case "${OSTYPE}" in
darwin*)
    $DOTFILES_PATH/homebrew/install.zsh $1
    ;;
esac
$DOTFILES_PATH/rust/install.zsh $1
