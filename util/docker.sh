#!/bin/bash

function docker_run() {
    image="$(docker image ls | tail -n +2 | fzf -x --cycle --layout=reverse)"
    docker run -it --rm "$image" "$1"
}

function docker_run_mnt() {
    image="$(docker image ls | tail -n +2 | fzf -x --cycle --layout=reverse)"
    docker run -it --rm -v "$PWD":/mnt "$image" bash
}
