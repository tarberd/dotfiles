########## Variables

dir=~/dotfiles                    # dotfiles directory
files=".vimrc"        		# list of files/folders to symlink in homedir

##########

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/$file
done

source ~/.vimrc
