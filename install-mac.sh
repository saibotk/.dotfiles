#!/bin/sh

# Path to your dotfiles.
export DOTFILES=$HOME/.dotfiles

# Paths to openssl to build pecl extensions (swoole)
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig"

echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle

# Rosetta is required for microsoft teams
softwareupdate --install-rosetta 

brew bundle --file $DOTFILES/macos/Brewfile

# Fix for https://github.com/Homebrew/homebrew-core/issues/74447
# gnupg is not really needed but marked as a dependency for pass
brew unlink gnupg

# Install pynvim for nvim
pip3 install --user pynvim

# Install PHP extensions with PECL
pecl install imagick redis

# Symlink pcre2, so pecl can find it when installing / building (needed for swoole)
sudo mkdir -p /usr/local/include
sudo ln -s /opt/homebrew/include/pcre2.h /usr/local/include/

# Install swoole with all features
yes | pecl install swoole

# Install global Composer packages
/opt/homebrew/bin/composer global require laravel/installer laravel/valet tightenco/takeout

# Install Laravel Valet
$HOME/.config/composer/vendor/bin/valet install

# Create a Sites directory
mkdir -p $HOME/git/clickbar
mkdir -p $HOME/git/konaktiva
mkdir -p $HOME/git/private

# Symlink the Mackup config file to the home directory
ln -s $DOTFILES/macos/.mackup.cfg $HOME/.mackup.cfg

# Set macOS preferences - we will run this last because this will reload the shell
source $DOTFILES/macos/.macos

# Call the general install script to setup zsh etc.
source install.sh
