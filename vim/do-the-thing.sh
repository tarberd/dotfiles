#!/bin/bash

set -e

source_dir=$(dirname `greadlink -f $0 || readlink -f $0`)
install_dir=$HOME/.vim

_install() {
  echo "Linking vim configuration files to '$install_dir'."
  install -d $install_dir
  ln -sf $source_dir/vimrc $install_dir/vimrc
  ln -sf $source_dir/defaults.vim $install_dir/defaults.vim
  ln -sf $source_dir/coc.vim $install_dir/coc.vim
  ln -sf $source_dir/coc-settings.json $install_dir/coc-settings.json
}

_remove() {
  rm $install_dir/vimrc
  rm $install_dir/defaults.vim
  rm $install_dir/coc.vim
  rm $install_dir/coc-settings.json
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
