#!/bin/zsh

function kc_stg() {
    export KUBECONFIG=$HOME/.kube/config/staging.yml
    echo_success "export KUBECONFIG=$KUBECONFIG\n"
}

function kc_prd() {
    export KUBECONFIG=$HOME/.kube/config/production.yml
    echo_success "export KUBECONFIG=$KUBECONFIG\n"
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
    current=$PWD
    for repo in $(ghq list --full-path); do
        cd $repo
        echo_success 'pull '
        echo "$repo"
        git switch master
        echo '\n'
    done
    cd $current
}

function cdg() {
    local repo=$(ghq list --full-path | peco)
    if [ -n "$repo" ]; then
        cd $repo
    fi
}

function codeg() {
    local repo=$(ghq list --full-path | peco)
    if [ -n "$repo" ]; then
        code $repo
    fi
}

function batg() {
    local dir=$(ghq list --full-path | peco)
    if [ -z "$dir" ]; then return; fi

    while [ -d $dir ]; do
        /bin/ls -a -1 $dir | peco | read s
        if [ -z "$s" ]; then return; fi
        dir="$dir/$s"
    done

    bat $dir
}

function vimg() {
    local dir=$(ghq list --full-path | peco)
    if [ -z "$dir" ]; then return; fi

    while [ -d $dir ]; do
        /bin/ls -a -1 $dir | peco | read s
        if [ -z "$s" ]; then return; fi
        dir="$dir/$s"
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
