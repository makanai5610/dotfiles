#!/bin/bash

function git_diff() {
    hash="$(git log --pretty="%cd %H %an %s" --date=format:'%Y/%m/%d %H:%M:%S' | fzf | awk '{print $3}')"
    if [ -z "$hash" ]; then
        return
    fi
    git diff "$hash"
}
