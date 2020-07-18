#!/bin/bash

set -e

source_dir=$(dirname `greadlink -f $0 || readlink -f $0`)
install_dir=$HOME/.config/skhd

_install() {
  echo "Linking skhd configuration files to '$install_dir'."
  install -d $install_dir
  ln -sf $source_dir/skdhrc $install_dir/skdhrc
}

_remove() {
  rm $install_dir/skdhrc
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
