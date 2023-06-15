# Path to your dotfiles.
export DOTFILES=$HOME/.dotfiles

# Load zsh-snap (znap) plugin manager
zstyle ':znap:*' repos-dir ~/.znap
source ~/.znap/znap/znap.zsh

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

# Load macos specific configs
if [[ $OSTYPE == 'darwin'* ]]; then
  source $DOTFILES/macos/path.zsh
fi

# Load extra files
source $DOTFILES/zsh/path.zsh

# Load aliases
source $DOTFILES/zsh/aliases.zsh

# localcommands
if [ -f $DOTFILES/zsh/localcommands ]
then
	source $DOTFILES/zsh/localcommands
fi

# ZSH prompt
znap eval starship 'starship init zsh --print-full-init'
