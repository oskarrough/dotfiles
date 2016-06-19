# Set where to install casks
set -x HOMEBREW_CASK_OPTS "--appdir=/Applications"

# Set default editor
set -gx EDITOR nvim

# Remove default fish startup message
set -gx fish_greeting

# Use Neovim instead of vim
abbr --add vim nvim

# Serves current directory on local network, port 8000.
alias serve 'eth0ip; and wlan0ip; and python -m SimpleHTTPServer'

# Git aliases
alias gs 'clear ;and git status -sb'
alias gup 'git stash ;and git pull --rebase ;and git stash apply'
alias gl 'git log --oneline --decorate' # Also shows tags!
alias glog "git log --graph \
            --abbrev-commit \
            --date=relative \
            --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset'"
alias gp 'git push origin HEAD'
alias gd 'git diff'
alias gc 'git commit --verbose'
alias gcm 'git commit -m'
alias gca 'git commit -a'
alias gcam 'git commit -am'
alias gco 'git checkout'
alias gb 'git branch'
alias ga 'git add'

# Set paths for Linuxbrew
# set -gx PATH ~/.linuxbrew/bin $PATH
# set -gx MANPATH ~/.linuxbrew/share/man: MANPATH
# set -gx INFOPATH ~/.linuxbrew/share/info $INFOPATH
# set -gx GIT_EDITOR nvim

# Linux set keyboard repeat delay and rate
#xset r rate 200 20
