#!/bin/sh

# Load common config environment variables
source ./config.env

echo "Setting up your system..."
echo "Your dotfiles path: $DOTFILES"

if [ ! -d ~/.znap/znap ]; then 
  echo "Installing znap..."
  sh -c "$(git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git ~/.znap/znap)"
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $DOTFILES/zsh/.zshrc $HOME/.zshrc

# Relink other software configs
# tmux
rm -rf $HOME/.tmux.conf
ln -s $DOTFILES/.tmux.conf $HOME/.tmux.conf

# nvim
rm -rf $HOME/.config/nvim
ln -s $DOTFILES/nvim $HOME/.config/nvim

# NVIM config:
# Install vim-plug for nvim
if [ ! -f ~/.config/nvim/autoload/plug.vim ]; then
  echo "Installing vim-plug for nvim"
  curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install + update all nvim plugins
nvim +PlugUpgrade +PlugUpdate +qall

echo "Done! All set up, ready to be used!"
