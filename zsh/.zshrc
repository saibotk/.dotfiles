# Path to your dotfiles.
export DOTFILES=$HOME/.dotfiles

# Load zsh-snap (znap) plugin manager
zstyle ':znap:*' repos-dir $HOME/.znap
source $HOME/.znap/znap/znap.zsh

# shell options
setopt correct                # Auto correct mistakes
setopt completealiases
setopt extendedglob           # Extended globbing. Allows using regular expressions with *
setopt nocaseglob             # Case insensitive globbing
setopt rcexpandparam          # Array expension with parameters
setopt nocheckjobs            # Don't warn about running processes when exiting
setopt numericglobsort        # Sort filenames numerically when it makes sense
setopt nobeep                 # No beep
setopt autocd                 # if only directory path is entered, cd there.

# history settings
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data
setopt appendhistory          # Immediately append history instead of overwriting
setopt inc_append_history

# completion settings
# Amazing guide: https://thevaluable.dev/zsh-completion-guide-examples/
setopt menu_complete
setopt nolistambiguous
ZSH_AUTOSUGGEST_STRATEGY=( history completion )
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*:*:*:*:descriptions' format '%F{cyan}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' file-list all                            # Show files like ls -la
zstyle ':completion:*' menu select yes                          # Show completion list menu and do not ask to display even long lists
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path 
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
# See https://github.com/zsh-users/zsh-autosuggestions/issues/118#issuecomment-184319846
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(expand-or-complete history-beginning-search-backward-end history-beginning-search-forward-end)

# Plugins
znap source jimhester/per-directory-history
znap source marlonrichert/zcolors
znap source zsh-users/zsh-history-substring-search
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting
znap source jessarcher/zsh-artisan

# Extra init code needed for zcolors.
znap eval zcolors zcolors

# Bind history key to substring plugin
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up			
bindkey '^[[B' history-substring-search-down

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
