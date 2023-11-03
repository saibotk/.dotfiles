#!/bin/sh

# Path to your dotfiles.
export DOTFILES=$HOME/.dotfiles

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

brew bundle --file ${DOTFILES}/macos/Brewfile

# Fix for https://github.com/Homebrew/homebrew-core/issues/74447
# gnupg is not really needed but marked as a dependency for pass
brew unlink gnupg

# Install pynvim for nvim
pip3 install --user pynvim

# Paths to openssl to build pecl extensions (swoole)
export PATH="${HOMEBREW_PREFIX}/opt/openssl@3/bin:$PATH"
export LDFLAGS="-L${HOMEBREW_PREFIX}/opt/openssl@3/lib"
export CPPFLAGS="-I${HOMEBREW_PREFIX}/opt/openssl@3/include"
export PKG_CONFIG_PATH="${HOMEBREW_PREFIX}/opt/openssl@3/lib/pkgconfig"

# Install PHP extensions with PECL
yes | pecl install imagick igbinary msgpack redis

# Symlink pcre2, so pecl can find it when installing / building (needed for swoole)
sudo mkdir -p /usr/local/include
sudo ln -s ${HOMEBREW_PREFIX}/include/pcre2.h /usr/local/include/

# Install swoole with all features
yes | pecl install swoole

# Install global Composer packages
${HOMEBREW_PREFIX}/bin/composer global require laravel/installer laravel/valet tightenco/takeout

# Install Laravel Valet
$HOME/.config/composer/vendor/bin/valet install

# Create a Sites directory
mkdir -p $HOME/git/clickbar
mkdir -p $HOME/git/konaktiva
mkdir -p $HOME/git/private

# Symlink the Mackup config file to the home directory
ln -s ${DOTFILES}/macos/.mackup.cfg $HOME/.mackup.cfg

# Activate asimov to automatically exclude node_modules from TM backup
sudo brew services start asimov

# Set macOS preferences - we will run this last because this will reload the shell
source ${DOTFILES}/macos/.macos

# Call the general install script to setup zsh etc.
source install.sh
