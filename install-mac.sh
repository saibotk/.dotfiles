#!/bin/sh

# Exit on error
set -e

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

brew bundle --file ${DOTFILES}/macos/Brewfile

# Fix for https://github.com/Homebrew/homebrew-core/issues/74447
# gnupg is not really needed but marked as a dependency for pass
brew unlink gnupg

flutter --disable-analytics

# Properly symlink openjdk java
# See https://formulae.brew.sh/formula/openjdk
sudo ln -sfn $HOMEBREW_PREFIX/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

# Enable corepack
corepack enable

# Install global Composer packages
${HOMEBREW_PREFIX}/bin/composer global require laravel/installer laravel/valet tightenco/takeout

# Install Laravel Valet
$HOME/.composer/vendor/bin/valet install

# Set Valet TLD to .localhost for secure context even in HTTP
yes | valet tld localhost

# Create dev directories
mkdir -p $HOME/git/clickbar
mkdir -p $HOME/git/konaktiva
mkdir -p $HOME/git/private

# Mark directories for Valet
valet park $HOME/git/clickbar
valet park $HOME/git/private

read -p "Enter a name for your MacBook, typically 'MacBook YOURNAME' [default: MacBook cb.]: " computername
computername=${computername:-MacBook cb.}
echo "Setting hostname to $computername"

# Set computer name (as done via System Preferences → Sharing)
sudo scutil --set ComputerName "$computername"
sudo scutil --set HostName "$computername"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$computername"

# Set macOS preferences - we will run this last because this will reload the shell
source ${DOTFILES}/macos/.macos

# Call the general install script to setup zsh etc.
source install.sh
