# Load common config environment variables
source config.env

# Load aliases
source $DOTFILES/zsh/aliases.zsh

# Load zsh-snap (znap) plugin manager
zstyle ':znap:*' repos-dir ~/.znap
source ~/.znap/znap/znap.zsh

# Helper Functions
# Returns whether the given command is executable or aliased.
_has() {
	return $( whence $1 >/dev/null )
}

# autocomplete settings
zstyle ':autocomplete:tab:*' widget-style menu-select
zstyle ':autocomplete:*' fzf-completion yes
zstyle ':autocomplete:*' min-input 2

# Plugins
znap source ohmyzsh/ohmyzsh lib/{git,theme-and-appearance}
znap source ohmyzsh/ohmyzsh plugins/{per-directory-history,git}
znap source marlonrichert/zcolors
znap source marlonrichert/zsh-autocomplete
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting
znap source jessarcher/zsh-artisan
znap source unixorn/fzf-zsh-plugin

# Extra init code needed for zcolors.
znap eval zcolors "zcolors ${(q)LS_COLORS}"

# ZSH prompt
if _has starship;
then
    znap eval starship 'starship init zsh --print-full-init'
else
    echo "You should try installing the starship prompt 🚀"
    znap prompt ohmyzsh/ohmyzsh robbyrussell
fi

# localcommands
if [ -f $DOTFILES/zsh/localcommands ]
then
	source $DOTFILES/zsh/localcommands
fi

# Set nvim as default editor
export EDITOR='nvim'
