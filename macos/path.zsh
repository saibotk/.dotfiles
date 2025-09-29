# Load Composer tools
export PATH="$HOME/.composer/vendor/bin:$PATH"

# Load Node global installed binaries
export PATH="$HOME/.node/bin:$PATH"

# Load GNU patch
export PATH="$HOMEBREW_PREFIX/opt/gpatch/libexec/gnubin:$PATH"

# Make sure coreutils are loaded before system commands
# I've disabled this for now because I only use "ls" which is
# referenced in my aliases.zsh file directly.
#export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

# Load dotfiles binaries for macos
export PATH="$DOTFILES/macos/bin:$PATH"

# Add Java binaries to path
# provides all openjdk binaries, otherwise some are not available
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
