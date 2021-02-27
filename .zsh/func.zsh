#!/bin/zsh

lg() {
    la | grep $1
}

kc_stg() {
    export KUBECONFIG=$HOME/.kube/config/staging.yml
    echo "export KUBECONFIG=$KUBECONFIG"
}

kc_prd() {
    export KUBECONFIG=$HOME/.kube/config/production.yml
    echo "export KUBECONFIG=$KUBECONFIG"
}

ksh() {
    if [ $# -eq 1 ]; then
        ke -it -n $1 $(kg pod -n $1 | sed -n 2p | awk '{print $1}') -- sh
    else
        echo 'must input namespace'
        kg namespaces
    fi
}

krc() {
    if [ $# -eq 1 ]; then
        ke -it -n $1 $(kg pod -n $1 | sed -n 2p | awk '{print $1}') -- bin/rails c
    else
        echo 'must input namespace'
        kg namespaces
    fi
}

ports() {
    if [ $# -eq 0 ]; then
        lsof -i -P
    elif [ $# -eq 1 ]; then
        lsof -i -P | grep $1
    else
        echo 'argument number should be 1 or 0.'
    fi
}

cdg() {
    local repo=$(ghq list --full-path | peco)
    if [ -n "$repo" ]; then
        cd $repo
    fi
}

ghq_update() {
    for repo in $(ghq list); do
        ghq get --update --parallel --silent $repo
    done
}

ghq_master() {
    current=$PWD
    for repo in $(ghq list --full-path); do
        cd $repo
        echo "$repo:"
        git switch master
        echo
    done
    cd $current
}

codeg() {
    local repo=$(ghq list --full-path | peco)
    if [ -n "$repo" ]; then
        code $repo
    fi
}

rubymine() {
    open -na "RubyMine.app" $(ghq list --full-path | peco)
}

intellij() {
    open -na "IntelliJ IDEA CE.app" $(ghq list --full-path | peco)
}

..() {
    cd ..
}

watch() {
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        local t=$1
        shift
        while true; do
            $@
            sleep ${t}s
        done
    else
        echo "should input number. got $1."
    fi
}

vimw() {
    local dir=$(ghq list --full-path | peco)
    if [ -z "$dir" ]; then return; fi

    while [ -d $dir ]; do
        /bin/ls -a -1 $dir | peco | read s
        if [ -z "$s" ]; then return; fi
        dir="$dir/$s"
    done

    vim $dir
}

skim() {
    local book_name=$(/bin/ls ~/books | peco)
    open -na "Skim.app" "$HOME/books/$book_name"
}
