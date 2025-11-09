# Load dotfiles binaries
export PATH="$DOTFILES/bin:$PATH"

# Use project specific binaries before global ones
export PATH="node_modules/.bin:vendor/bin:$PATH"

# Set nvim as default editor
export EDITOR='nvim'

# Fix git log color sequences
export LESS='-R'

# proto (toolchain package manager)
export PROTO_HOME="$XDG_DATA_HOME/proto";
export PATH="$PROTO_HOME/shims:$PROTO_HOME/bin:$PATH";
