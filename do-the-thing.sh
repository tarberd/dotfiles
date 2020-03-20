#!/bin/bash

set -e

_install() {
  ./alacritty/do-the-thing.sh install
  ./latexmk/do-the-thing.sh install
  ./rofi/do-the-thing.sh install
  ./skhd/do-the-thing.sh install
  ./sway/do-the-thing.sh install
  ./termite/do-the-thing.sh install
  ./vim/do-the-thing.sh install
  ./waybar/do-the-thing.sh install
  ./yabai/do-the-thing.sh install
  ./zsh/do-the-thing.sh install
}

_remove() {
  ./alacritty/do-the-thing.sh remove
  ./latexmk/do-the-thing.sh remove
  ./rofi/do-the-thing.sh remove
  ./skhd/do-the-thing.sh remove
  ./sway/do-the-thing.sh remove
  ./termite/do-the-thing.sh remove
  ./vim/do-the-thing.sh remove
  ./waybar/do-the-thing.sh remove
  ./yabai/do-the-thing.sh remove
  ./zsh/do-the-thing.sh remove
}

if [ $1 == "install" ]
then
  _install
  exit 0
elif [ $1 == "remove" ]
then
  _remove
  exit 0
else
  echo "Please provide install or remove argument."
  exit 1
fi
