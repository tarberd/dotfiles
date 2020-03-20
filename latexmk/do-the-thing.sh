#!/bin/bash

set -e

source_dir=$(dirname $(readlink -f $0))
install_dir=$HOME/

_install() {
  echo "Linking latexmk configuration files to '$install_dir'."
  install -d $install_dir
  ln -sf $source_dir/latexmkrc $install_dir/.latexmkrc
}

_remove() {
  rm $install_dir/.latexmkrc
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
