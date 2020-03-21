#!/bin/bash

set -e

source_dir=$(dirname $(readlink -f $0))
install_dir=$HOME/.config/waybar


_install() {
  echo "Linking waybar configuration files to '$install_dir'."
  echo "Remember to install dependencies for mediaplayer and keyboard-layout scripts."

  install -d $install_dir
  ln -sf $source_dir/config $install_dir/config
  ln -sf $source_dir/style.css $install_dir/style.css
  ln -sf $source_dir/mediaplayer.py $install_dir/mediaplayer.py
  ln -sf $source_dir/keyboard-layout.sh $install_dir/keyboard-layout.sh
}

_remove() {
  rm $install_dir/config
  rm $install_dir/style.css
  rm $install_dir/mediaplayer.py
  rm $install_dir/keyboard-layout.sh
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
