#!/bin/sh

git config --global user.email "bernardo.mferrari@gmail.com"
git config --global user.name "tarberd"
git config --global core.editor "vim"

if [ ! -d  "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

mkdir $HOME/.config

mkdir $HOME/.config/rofi
ln -sf $HOME/dotfiles/rofi/config $HOME/.config/rofi/config

mkdir $HOME/.config/polybar
ln -sf $HOME/dotfiles/polybar/config $HOME/.config/polybar/config

mkdir $HOME/.config/waybar
ln -sf $HOME/dotfiles/waybar/config $HOME/.config/waybar/config
ln -sf $HOME/dotfiles/waybar/style.css $HOME/.config/waybar/style.css

mkdir $HOME/.vim
ln -sf $HOME/dotfiles/vim/vimrc $HOME/.vim/vimrc
ln -sf $HOME/dotfiles/vim/coc-settings.json $HOME/.vim/coc-settings.json

ln -sf $HOME/dotfiles/latexmk/latexmkrc $HOME/.latexmkrc

mkdir $HOME/.config/i3
ln -sf $HOME/dotfiles/i3/config $HOME/.config/i3/config

mkdir $HOME/.config/sway
ln -sf $HOME/dotfiles/sway/config $HOME/.config/sway/config

mkdir $HOME/.config/termite
ln -sf $HOME/dotfiles/termite/config $HOME/.config/termite/config

mkdir $HOME/.config/alacritty
ln -sf $HOME/dotfiles/alacritty/alacritty.yml $HOME/.config/alacritty/alacritty.yml

ln -sf $HOME/dotfiles/skhd/skhdrc $HOME/.skhdrc

mkdir $HOME/.config/yabai
ln -sf $HOME/dotfiles/yabai/yabairc $HOME/.config/yabai/yabairc
