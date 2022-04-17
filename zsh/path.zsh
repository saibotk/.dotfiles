# Load dotfiles binaries
export PATH="$DOTFILES/bin:$PATH"

# Use project specific binaries before global ones
export PATH="node_modules/.bin:vendor/bin:$PATH"

# Set nvim as default editor
export EDITOR='nvim'
