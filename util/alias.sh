#!/bin/bash

alias ..='cd ..'
alias cat='bat'
alias l='exa -lbghHimSuU@ --time-style long-iso --git -s Name'
alias ls='exa -lbghHimSuU@ --time-style long-iso --git -s Name'
alias ll='exa -lbghHimSuU@ --time-style long-iso --git -s Name'
alias la='exa -labghHimSuU@ --time-style long-iso --git -s Name'
alias grep='rg'
alias find='fd'
#alias ps='procs'
#alias vim='nvim'
#alias top='ytop'
#alias top='bandwhich'
#alias top='btm'

alias yq='yq eval -C'

alias gorepl='gore'
alias rustrepl='evcxr'

# kubernetes
alias k='kubectl'
alias kex='k exec'
alias kg='k get'
alias ked='k edit'

# memo
alias mmn='memo new'
alias mml='memo list'
alias mme='memo edit'
alias mmc='memo cat'
