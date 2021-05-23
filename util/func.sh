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
    ghq list >>"$DOTFILES_PATH/ghq/repo.txt"
    (/bin/cat "$DOTFILES_PATH/ghq/repo.txt" | grep -v -f "$DOTFILES_PATH/ghq/ignore_word.txt" | sort | uniq) >"$DOTFILES_PATH/ghq/repo.txt.copy"
    rm "$DOTFILES_PATH/ghq/repo.txt"
    mv "$DOTFILES_PATH/ghq/repo.txt.copy" "$DOTFILES_PATH/ghq/repo.txt"
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
    local config=$HOME/.kube/config/staging.yml
    if [ -e "$config" ]; then
        export KUBECONFIG=$config
        echo_success "export KUBECONFIG=$KUBECONFIG\n"
    else
        echo_failure "$config is not found.\n"
    fi
}

function kc_prd() {
    local config=$HOME/.kube/config/production.yml
    if [ -e "$config" ]; then
        export KUBECONFIG=$config
        echo_success "export KUBECONFIG=$KUBECONFIG\n"
    else
        echo_failure "$config is not found.\n"
    fi
}

function ksh() {
    if [ $# -eq 1 ]; then
        kex -it -n "$1" $(kg pod -n $1 | grep Running | sed -n 1p | awk '{print $1}') -- sh
    else
        echo_failure 'must input namespace.\n'
        kg namespaces
    fi
}

function krc() {
    if [ $# -eq 1 ]; then
        kex -it -n "$1" $(kg pod -n $1 | grep Running | sed -n 1p | awk '{print $1}') -- bin/rails c
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

function ghq_default() {
    local current_directory=$PWD
    for repo in $(ghq list --full-path); do
        cd $repo
        echo_success 'switch '
        echo "$repo"
        local current_branch_name
        current_branch_name=$(git branch --show-current)
        local default_branch_name
        default_branch_name=$(git symbolic-ref refs/remotes/origin/HEAD | awk -F'[/]' '{print $NF}')
        if [ "$current_branch_name" = "$default_branch_name" ]; then
            echo "    already on '$default_branch_name'"
        else
            echo "    $current_branch_name -> $default_branch_name"
            git switch $default_branch_name
        fi
    done
    cd $current_directory
}

function path() {
    local dir
    dir=$(ghq list --full-path | peco)
    if [ -z "$dir" ]; then
        return
    fi

    while [ -d "$dir" ]; do
        /bin/ls -Fa1 "$dir" | peco | read s
        if [ -z "$s" ]; then
            break
        fi

        dir="$dir/$s"
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

function cdp() {
    local dir
    dir=$(/bin/ls -Fa | grep / | peco)
    if [ -z "$dir" ]; then
        echo_failure "canceled\n"
        reset_style
        return
    fi

    echo_success "selected "
    reset_style
    echo "$dir"

    while [ $(/bin/ls -Fa $dir | grep / | wc -l) != 0 ]; do
        /bin/ls -Fa "$dir" | grep / | peco | read s
        if [ -z "$s" ]; then break; fi
        dir="$dir$s"

        echo_success "selected "
        reset_style
        echo "$dir"
    done

    cd "$dir"
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

    while [ -d "$dir" ]; do
        /bin/ls -a "$dir" | peco | read s
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

    while [ -d "$dir" ]; do
        /bin/ls -a "$dir" | peco | read s
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

    vim "$dir"
}

function watch() {
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        local t=$1
        shift
        while true; do
            $@
            sleep "${t}s"
        done
    else
        echo_failure "should input number. got $1.\n"
    fi
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
