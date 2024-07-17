umask 022

PATH="${HOME}/.local/bin:${PATH}"

HOMEBREW_RELOCATE_BUILD_PREFIX=1
export HOMEBREW_RELOCATE_BUILD_PREFIX
eval "$(/loc/bernardo/.brew/bin/brew shellenv)"

export PATH

XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CONFIG_HOME

export EDITOR=nvim
export SHELL=$(which zsh)

TSF_LOC_HOME=/loc/bernardo
export TSF_LOC_HOME

_RR_TRACE_DIR=/loc/${USER}/.local/share/rr
export _RR_TRACE_DIR
