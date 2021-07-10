#!/bin/bash

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
