#!/bin/zsh

# FileSearch
function f() { find . -iname "*$1*" ${@:2} }
function r() { grep "$1" ${@:2} -R . }

#mkdir and cd
function mkcd() { mkdir -p "$@" && cd "$_"; }

# Aliases
alias cppcompile='c++ -std=c++11 -stdlib=libc++'
alias ls=la

# Use sublimetext for editing config files
alias zshconfig="vim ~/.zshrc"
alias envconfig="vim ~/workspace/env.sh"
