# Shortcuts

# MacOS specifics
if [[ $OSTYPE == 'darwin'* ]]; then
    alias clip="pbcopy"
    alias copyssh="pbcopy < $HOME/.ssh/id_ed25519.pub"
    alias ls="/opt/homebrew/opt/coreutils/libexec/gnubin/ls"
    alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
    alias composer="php -d memory_limit=-1 /opt/homebrew/bin/composer"
fi

# Linux specifics
if [[ $OSTYPE == 'linux'* ]]; then
    alias clip="xclip -sel clip"
    alias copyssh="cat $HOME/.ssh/id_rsa.pub | clip"

    alias pnpm="firejail pnpm"
    alias yarn="firejail yarn"
    alias npm="firejail npm"
fi

# General
alias reloadshell="source $HOME/.zshrc"
alias ll="ls -AhlFo --color --group-directories-first"
alias shrug="echo '¯\_(ツ)_/¯' | clip"
alias c="clear"
alias compile="commit 'compile'"
alias version="commit 'version'"

# Directories
alias dotfiles="cd $DOTFILES"

# Laravel
alias a="php artisan"
alias mfs="php artisan migrate:fresh --seed"
alias tinker="php artisan tinker"
alias seed="php artisan db:seed"
alias serve="php artisan serve"

# PHP
alias cfresh="rm -rf vendor/ composer.lock && composer i"

# JS
alias nfresh="rm -rf node_modules/ package-lock.json && npm install"
alias watch="npm run watch"

# Git
alias gst="git status"
alias gb="git branch"
alias gc="git checkout"
alias gl="git log --oneline --decorate --color"
alias amend="git add . && git commit --amend --no-edit"
alias commit="git add . && git commit -m"
alias diff="git diff"
alias force="git push --force"
alias nuke="git clean -df && git reset --hard"
alias pop="git stash pop"
alias pull="git pull"
alias push="git push"
alias resolve="git add . && git commit --no-edit"
alias stash="git stash -u"
alias unstage="git restore --staged ."
alias wip="commit wip"
