#!/bin/bash

function ghq_fetch() {
    local current_directory=$PWD
    for repo in $(ghq list --full-path); do
        cd "$repo"
        echo_success 'fetch '
        echo "$repo"
        git fetch --prune
    done
    cd "$current_directory"
}

function ghq_update() {
    for repo in $(ghq list); do
        ghq get --update --parallel "$repo"
    done
}
