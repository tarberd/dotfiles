#!/bin/bash

set -e

source_dir=$(dirname $(readlink -f $0))
install_dir=$HOME/.config/yabai

_install() {
  echo "Linking rofi configuration files to '$install_dir'."
  install -d $install_dir
  ln -sf $source_dir/yabairc $install_dir/yabairc
}

_remove() {
  rm $install_dir/yabairc
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
