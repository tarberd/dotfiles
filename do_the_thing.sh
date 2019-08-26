git config --global user.email "bernardo.mferrari@gmail.com"
git config --global user.name "tarberd"
git config --global core.editor "vim"

DIRECTORY_VUNDLE="$HOME/.vim/bundle/Vundle.vim"

if [ ! -d  "$DIRECTORY_VUNDLE" ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git $DIRECTORY_VUNDLE
fi

if [ ! -d  "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

mkdir $HOME/.config
mkdir $HOME/.config/i3
mkdir $HOME/.config/sway
mkdir $HOME/.config/termite

mkdir $HOME/.config/rofi
ln -sf $HOME/dotfiles/rofi/config $HOME/.config/rofi/config

mkdir $HOME/.config/polybar
ln -sf $HOME/dotfiles/polybar/config $HOME/.config/polybar/config

mkdir $HOME/.config/waybar
ln -sf $HOME/dotfiles/waybar/config $HOME/.config/waybar/config
ln -sf $HOME/dotfiles/waybar/style.css $HOME/.config/waybar/style.css

ln -sf $HOME/dotfiles/zsh/zshrc $HOME/.zshrc
ln -sf $HOME/dotfiles/vim/vimrc $HOME/.vimrc
ln -sf $HOME/dotfiles/i3/config $HOME/.config/i3/config
ln -sf $HOME/dotfiles/sway/config $HOME/.config/sway/config
ln -sf $HOME/dotfiles/termite/config $HOME/.config/termite/config

ln -sf $HOME/dotfiles/chunkwm/chunkwmrc $HOME/.chunkwmrc
ln -sf $HOME/dotfiles/skhd/skhdrc $HOME/.skhdrc
ln -sf $HOME/dotfiles/alacritty/alacritty.yml $HOME/.config/alacritty/alacritty.yml
