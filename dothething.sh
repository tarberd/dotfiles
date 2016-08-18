DIRECTORY="$HOME/.vim/bundle/Vundle.vim"

ln -s $HOME/dotfiles/vim/vimrc ~/.vimrc


if [ ! -d  "$DIRECTORY" ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git $DIRECTORY
fi

vim +PluginInstall
