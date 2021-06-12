#!/bin/bash

# if $1 is 'dry', dry run.
case "${OSTYPE}" in
darwin*)
    $DOTFILES_PATH/homebrew/install.sh $1
    ;;
esac
$DOTFILES_PATH/go/install.sh $1
$DOTFILES_PATH/rust/install.sh $1
