#!/bin/bash

function rubymine() {
    repo=$(ghq list --full-path | fzf -x --cycle --layout=reverse)
    if [ -z "$repo" ]; then
        echo_failure "canceled\n"
        reset_style
        return
    fi

    echo_success "selected "
    reset_style
    echo "$repo"
    open -na 'RubyMine.app' "$repo"
}

function intellij() {
    repo=$(ghq list --full-path | fzf -x --cycle --layout=reverse)
    if [ -z "$repo" ]; then
        echo_failure "canceled\n"
        reset_style
        return
    fi

    echo_success "selected "
    reset_style
    echo "$repo"
    open -na 'IntelliJ IDEA CE.app' "$repo"
}

function skim() {
    book=$(/bin/ls ~/books | fzf -x --cycle --layout=reverse)
    if [ -z "$book" ]; then
        echo_failure "canceled\n"
        reset_style
        return
    fi

    echo_success "selected "
    reset_style
    echo "$book"
    open -na "Skim.app" "$HOME/books/$book"
}

function notion() {
    open -na "Notion.app"
}
