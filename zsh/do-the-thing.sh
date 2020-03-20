#!/bin/bash

set -e

source_dir=$(dirname $(readlink -f $0))
install_dir=$HOME

base16_shell_path="$HOME/.config/base16-shell"

_install() {
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  fi

  if [ ! -d $base16_shell_path ]; then
    git clone https://github.com/chriskempson/base16-shell.git $base16_shell_path
  fi

  echo "Linking zsh configuration files to '$install_dir'."
  install -d $install_dir
  ln -sf $source_dir/zshrc $install_dir/.zshrc
  ln -sf $source_dir/zprofile $install_dir/.zprofile
}

_remove() {
  rm $install_dir/.zshrc
  rm $install_dir/.zprofile
  rm -rf "$HOME/.oh-my-zsh"
  rm -rf $base16_shell_path
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
