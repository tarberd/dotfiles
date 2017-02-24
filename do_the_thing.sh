DIRECTORY="$HOME/.vim/bundle/Vundle.vim"

ln -sf $HOME/dotfiles/i3/config $HOME/.config/i3/config
ln -sf $HOME/dotfiles/vim/vimrc $HOME/.vimrc

if [ ! -d  "$DIRECTORY" ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git $DIRECTORY
fi

vim +PluginInstall
