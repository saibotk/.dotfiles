# Load Composer tools
export PATH="$HOME/composer/vendor/bin:$PATH"

# Load Node global installed binaries
export PATH="$HOME/.node/bin:$PATH"

# Make sure coreutils are loaded before system commands
# I've disabled this for now because I only use "ls" which is
# referenced in my aliases.zsh file directly.
#export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

# Load dotfiles binaries for macos
export PATH="$DOTFILES/macos/bin:$PATH"
