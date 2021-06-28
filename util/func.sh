#!/bin/bash

function update_all() {
    case "${OSTYPE}" in
    darwin*)
        brew upgrade
        brew autoremove
        brew cleanup
        pushd $DOTFILES_PATH/homebrew >/dev/null
        brew bundle install --cleanup --no-lock
        popd >/dev/null
        ;;
    linux*)
        sudo apt update
        sudo apt upgrade
        sudo apt autoremove
        sudo apt clean
        ;;
    esac

    rustup update
    ghq_fetch
    ghq_update
}

function link_dotfiles() {
    "$DOTFILES_PATH/link.sh"
}

function sync_brewfile() {
    pushd $DOTFILES_PATH/homebrew >/dev/null
    mv Brewfile Brewfile.before
    brew bundle dump
    mv Brewfile Brewfile.dumped
    /bin/cat Brewfile.before Brewfile.dumped | sort | uniq >Brewfile
    rm Brewfile.before Brewfile.dumped
    popd >/dev/null
}

function lg() {
    la | grep "$1"
}

function kc_stg() {
    link_kube_conf "$HOME/.kube/config_staging.yml"
}

function kc_prd() {
    link_kube_conf "$HOME/.kube/config_production.yml"
}

function link_kube_conf() {
    local config=$1
    if [ -e "$config" ]; then
        ln -si "$config" "$HOME/.kube/config"
        echo_success "link"
        echo " $config -> $KUBECONFIG"
    else
        echo_failure "$config is not found.\n"
    fi
}

function docker_run() {
    image="$(docker image ls | tail -n +2 | peco | awk '{print $1 ":" $2}')"
    docker run -it --rm "$image" "$1"
}

function docker_run_mnt() {
    image="$(docker image ls | tail -n +2 | peco | awk '{print $1 ":" $2}')"
    docker run -it --rm -v "$PWD":/mnt "$image" bash
}

function ksh() {
    if [ $# -eq 1 ]; then
        kex -it -n "$1" "$(kg pod -n $1 | grep Running | head -n 1 | awk '{print $1}')" -- sh
    else
        echo_failure 'must input namespace.\n'
        kg namespaces
    fi
}

function krc() {
    if [ $# -eq 1 ]; then
        kex -it -n "$1" "$(kg pod -n $1 | grep Running | head -n 1 | awk '{print $1}')" -- bin/rails c
    else
        echo_failure 'must input namespace.\n'
        kg namespaces
    fi
}

function ports() {
    if [ $# -eq 0 ]; then
        lsof -i -P
    elif [ $# -eq 1 ]; then
        lsof -i -P | grep "$1"
    else
        echo_failure 'argument number should be 1 or 0.\n'
    fi
}

function ghq_fetch() {
    local current_directory=$PWD
    for repo in $(ghq list --full-path); do
        cd $repo
        echo_success 'fetch '
        echo "$repo"
        git fetch --prune
    done
    cd $current_directory
}

function ghq_update() {
    for repo in $(ghq list); do
        ghq get --update --parallel $repo
    done
}

function ghq_install() {
    filepath=$1
    if [ -z $1 ]; then
        echo_failure "error"
        reset_style
        echo " must need filepath"
    fi

    while read repo; do
        ghq get "https://$repo.git"
    done <$filepath
}

function path() {
    local dir
    dir=$(ghq list --full-path | peco)
    if [ -z "$dir" ]; then
        return
    fi
    dir="$dir/"

    while [ -d "$dir" ]; do
        /bin/ls -ap "$dir" | peco | read s
        if [ -z "$s" ]; then
            break
        fi

        dir="$dir$s"
    done

    echo "$dir"
}

function cdg() {
    local repo
    repo=$(ghq list --full-path | peco)
    if [ -z "$repo" ]; then
        echo_failure "canceled\n"
        reset_style
        return
    fi

    echo_success "selected "
    reset_style
    echo "$repo"

    cd "$repo"
}

function codeg() {
    local repo
    repo=$(ghq list --full-path | peco)
    if [ -z "$repo" ]; then
        echo_failure "canceled\n"
        reset_style
        return
    fi

    echo_success "selected "
    reset_style
    echo "$repo"

    code "$repo"
}

function batg() {
    local dir
    dir=$(ghq list --full-path | peco)
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
        /bin/ls -ap "$dir" | peco | read s
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
    local dir
    dir=$(ghq list --full-path | peco)
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
        /bin/ls -ap "$dir" | peco | read s
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

function mmc() {
    m=$(/bin/ls -F $XDG_CONFIG_HOME/memo/_posts | peco)
    if [ -z "$m" ]; then
        echo_failure "canceled\n"
        reset_style
        return
    fi

    glow "$XDG_CONFIG_HOME/memo/_posts/$m"
}

function mmd() {
    memo delete "$(memo list --fullpath | peco | xargs basename)"
}

function _man() {
    export PAGER=$(which bat)
    man $@
    unset PAGER
}

function rubymine() {
    local repo
    repo=$(ghq list --full-path | peco)
    if [ -z "$repo" ]; then
        echo_failure "canceled\n"
        reset_style
        return
    fi

    echo_success "selected "
    reset_style
    echo "$repo"
    open -na 'RubyMine.app' $repo
}

function intellij() {
    local repo
    repo=$(ghq list --full-path | peco)
    if [ -z "$repo" ]; then
        echo_failure "canceled\n"
        reset_style
        return
    fi

    echo_success "selected "
    reset_style
    echo "$repo"
    open -na 'IntelliJ IDEA CE.app' $repo
}

function skim() {
    local book
    book=$(/bin/ls ~/books | peco)
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
