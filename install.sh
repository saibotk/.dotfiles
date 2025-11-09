#!/bin/sh

# Path to your dotfiles.
export DOTFILES=$HOME/.dotfiles

echo "Setting up your system..."
echo "Your dotfiles path: $DOTFILES"

if [ ! -d $HOME/.znap/znap ]; then 
  echo "Installing znap..."
  sh -c "$(git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git $HOME/.znap/znap)"
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $DOTFILES/zsh/.zshrc $HOME/.zshrc

# Relink other software configs

# git
# We only include our config here to allow other tools to still modify the gitconfig locally with user specific paths etc.
# E.g. znap adds maintenance entries there.
if ! grep -q "path = $DOTFILES/.gitconfig" ~/.gitconfig; then
echo "Adding gitconfig include statement to ~/.gitconfig"

echo """
[include]
path = $DOTFILES/.gitconfig
""" >> $HOME/.gitconfig
fi

# nvim
rm -rf $HOME/.config/nvim
mkdir -p $HOME/.config
ln -s $DOTFILES/nvim $HOME/.config/nvim

# ghostty
rm -rf $HOME/.config/ghostty
mkdir -p $HOME/.config
ln -s $DOTFILES/ghostty $HOME/.config/ghostty

# NVIM config:
# Install vim-plug for nvim
if [ ! -f ~/.config/nvim/autoload/plug.vim ]; then
  echo "Installing vim-plug for nvim"
  curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install + update all nvim plugins
# nvim +PlugUpgrade +PlugUpdate +qall

# Install common package managers
proto install node
proto install pnpm
proto install bun
proto install uv

echo "Done! All set up, ready to be used!"
