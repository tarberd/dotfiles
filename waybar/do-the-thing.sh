#!/bin/bash

set -e

source_dir=$(dirname $(readlink -f $0))
install_dir=$HOME/.config/waybar

_install() {
  echo "Linking rofi configuration files to '$install_dir'."
  install -d $install_dir
  ln -sf $source_dir/config $install_dir/config
  ln -sf $source_dir/style.css $install_dir/style.css
}

_remove() {
  rm $install_dir/config
  rm $install_dir/style.css
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
