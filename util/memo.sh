#!/bin/bash

function mmc() {
    m=$(memo list --fullpath | fzf -x --layout=reverse)
    if [ -z "$m" ]; then
        echo_failure "canceled\n"
        reset_style
        return
    fi

    /bin/cat "$m"
}

function mmd() {
    memo delete "$(memo list --fullpath | fzf -x --layout=reverse --preview="bat --color=always --style=header,grid,numbers {}" | xargs basename)"
}

function mml() {
    memo list --fullpath | fzf -x --layout=reverse --preview="bat --color=always --style=header,grid,numbers {}"
}
