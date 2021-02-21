#!/usr/local/bin/zsh

script_dir=$(
    if [ -n "$(readlink $0)" ]; then
        cd "$(dirname $(readlink $0))"
        pwd
    else
        cd "$(dirname $0)"
        pwd
    fi
)

alias cat='bat'
alias l='exa -lbghHimSuU@ --time-style long-iso --git -s Name'
alias ls='exa -lbghHimSuU@ --time-style long-iso --git -s Name'
alias ll='exa -lbghHimSuU@ --time-style long-iso --git -s Name'
alias la='exa -labghHimSuU@ --time-style long-iso --git -s Name'
alias grep='rg'
alias find='fd'
#alias ps='procs'
alias vim='nvim'
#alias top='ytop'
#alias top='bandwhich'
#alias top='btm'

alias gorepl='gore'
alias rustrepl='evcxr'
