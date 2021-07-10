#!/bin/bash

function path() {
    dir=$(ghq list --full-path | fzf -x --layout=reverse --preview="if [ -f $dir{} ]; then bat --color=always --style=header,grid,numbers $dir{}; fi")
    if [ -z "$dir" ]; then
        return
    fi
    dir="$dir/"

    while [ -d "$dir" ]; do
        /bin/ls -ap "$dir" | fzf -x --layout=reverse --preview="if [ -f $dir{} ]; then bat --color=always --style=header,grid,numbers $dir{}; fi" | read s
        if [ -z "$s" ]; then
            break
        fi

        dir="$dir$s"
    done

    echo "$dir"
}

function cdg() {
    dir=$(ghq list --full-path | fzf -x --layout=reverse --preview="if [ -f $dir{} ]; then bat --color=always --style=header,grid,numbers $dir{}; fi")
    if [ -z "$dir" ]; then
        echo_failure "canceled\n"
        reset_style
        return
    fi

    echo_success "selected "
    reset_style
    echo "$dir"

    cd "$dir"
}

function codeg() {
    dir=$(ghq list --full-path | fzf -x --layout=reverse --preview="if [ -f $dir{} ]; then bat --color=always --style=header,grid,numbers $dir{}; fi")
    if [ -z "$dir" ]; then
        echo_failure "canceled\n"
        reset_style
        return
    fi

    echo_success "selected "
    reset_style
    echo "$dir"

    code "$dir"
}

function batg() {
    dir=$(ghq list --full-path | fzf -x --layout=reverse --preview="if [ -f $dir{} ]; then bat --color=always --style=header,grid,numbers $dir{}; fi")
    if [ -z "$dir" ]; then
        echo_failure "canceled\n"
        reset_style
        return
    fi

    echo_success "selected "
    reset_style
    echo "$dir"
    dir="$dir/"

    while [ -d "$dir" ]; do
        /bin/ls -ap "$dir" | fzf -x --layout=reverse --preview="if [ -f $dir{} ]; then bat --color=always --style=header,grid,numbers $dir{}; fi" | read s
        if [ -z "$s" ]; then
            echo_failure "canceled\n"
            reset_style
            return
        fi

        dir="$dir$s"

        echo_success "selected "
        reset_style
        echo "$dir"
    done

    bat "$dir"
}

function vimg() {
    dir=$(ghq list --full-path | fzf -x --layout=reverse --preview="if [ -f $dir{} ]; then bat --color=always --style=header,grid,numbers $dir{}; fi")
    if [ -z "$dir" ]; then
        echo_failure "canceled\n"
        reset_style
        return
    fi

    echo_success "selected "
    reset_style
    echo "$dir"
    dir="$dir/"

    while [ -d "$dir" ]; do
        /bin/ls -ap "$dir" | fzf -x --layout=reverse --preview="if [ -f $dir{} ]; then bat --color=always --style=header,grid,numbers $dir{}; fi" | read s
        if [ -z "$s" ]; then
            echo_failure "canceled\n"
            reset_style
            return
        fi

        dir="$dir$s"

        echo_success "selected "
        reset_style
        echo "$dir"
    done

    vim "$dir"
}
