#!/bin/zsh

# protobuf
export PATH=$PATH:/usr/local/opt/protobuf/bin

# go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk-14.0.2.jdk/Contents/Home
export PATH=$PATH:$JAVA_HOME/bin

# rust
export PATH=$PATH:$HOME/.cargo/bin
export RUSTC_WRAPPER=$(which sccache)

# ruby
[[ -d ~/.rbenv ]] &&
    export PATH=${HOME}/.rbenv/bin:${PATH} &&
    eval "$(rbenv init -)"

# node
export PATH=$PATH:$HOME/.nodenv/bin
eval "$(nodenv init -)"
