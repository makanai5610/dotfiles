#!/bin/zsh

function kc_stg() {
    local config=$HOME/.kube/config/staging.yml
    if [ ! -a config ]; then
        echo_failure "$config is not found.\n"
    else
        export KUBECONFIG=$config
        echo_success "export KUBECONFIG=$KUBECONFIG\n"
    fi
}

function kc_prd() {
    local config=$HOME/.kube/config/production.yml
    if [ ! -a config ]; then
        echo_failure "$config is not found.\n"
    else
        export KUBECONFIG=$config
        echo_success "export KUBECONFIG=$KUBECONFIG\n"
    fi
}

function ksh() {
    if [ $# -eq 1 ]; then
        ke -it -n $1 $(kg pod -n $1 | sed -n 2p | awk '{print $1}') -- sh
    else
        echo_failure 'must input namespace.\n'
        kg namespaces
    fi
}

function krc() {
    if [ $# -eq 1 ]; then
        ke -it -n $1 $(kg pod -n $1 | sed -n 2p | awk '{print $1}') -- bin/rails c
    else
        echo_failure 'must input namespace.\n'
        kg namespaces
    fi
}

function ports() {
    if [ $# -eq 0 ]; then
        lsof -i -P
    elif [ $# -eq 1 ]; then
        lsof -i -P | grep $1
    else
        echo_failure 'argument number should be 1 or 0.\n'
    fi
}

function ghq_update() {
    for repo in $(ghq list); do
        ghq get --update --parallel --silent $repo
    done
}

function ghq_master() {
    local current=$PWD
    for repo in $(ghq list --full-path); do
        echo_success 'pull '
        echo "$repo"

        cd $repo
        git switch master

        echo
    done

    cd $current
}

function cdg() {
    local repo=$(ghq list --full-path | peco)
    if [ -z "$repo" ]; then
        echo_failure "canceled\n"
        reset_style
        return
    fi

    echo_success "selected "
    reset_style
    echo "$dir"

    cd $repo
}

function cdp() {
    local dir=$(/bin/ls -Fa -1 | grep / | peco)
    if [ -z "$dir" ]; then
        echo_failure "canceled\n"
        reset_style
        return
    fi

    echo_success "selected "
    reset_style
    echo "$dir"

    while [ $(/bin/ls -F $dir | grep / | wc -l) != 0 ]; do
        /bin/ls -Fa -1 $dir | grep / | peco | read s
        if [ -z "$s" ]; then break; fi
        dir="$dir$s"

        echo_success "selected "
        reset_style
        echo "$dir"
    done

    cd $dir
}

function codeg() {
    local repo=$(ghq list --full-path | peco)
    if [ -z "$repo" ]; then
        echo_failure "canceled\n"
        reset_style
        return
    fi

    echo_success "selected "
    reset_style
    echo "$repo"

    code $repo
}

function batg() {
    local dir=$(ghq list --full-path | peco)
    if [ -z "$dir" ]; then
        echo_failure "canceled\n"
        reset_style
        return
    fi

    echo_success "selected "
    reset_style
    echo "$dir"

    while [ -d $dir ]; do
        /bin/ls -a -1 $dir | peco | read s
        if [ -z "$s" ]; then
            echo_failure "canceled\n"
            reset_style
            return
        fi

        dir="$dir/$s"

        echo_success "selected "
        reset_style
        echo "$dir"
    done

    bat $dir
}

function vimg() {
    local dir=$(ghq list --full-path | peco)
    if [ -z "$dir" ]; then
        echo_failure "canceled\n"
        reset_style
        return
    fi

    echo_success "selected "
    reset_style
    echo "$dir"

    while [ -d $dir ]; do
        /bin/ls -a -1 $dir | peco | read s
        if [ -z "$s" ]; then
            echo_failure "canceled\n"
            reset_style
            return
        fi

        dir="$dir/$s"

        echo_success "selected "
        reset_style
        echo "$dir"
    done

    vim $dir
}

function watch() {
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        local t=$1
        shift
        while true; do
            $@
            sleep ${t}s
        done
    else
        echo_failure "should input number. got $1.\n"
    fi
}

function rubymine() {
    open -na 'RubyMine.app' $(ghq list --full-path | peco)
}

function intellij() {
    open -na 'IntelliJ IDEA CE.app' $(ghq list --full-path | peco)
}

function skim() {
    open -na "Skim.app" "$HOME/books/$(/bin/ls ~/books | peco)"
}

function notion() {
    open -na "Notion.app"
}

