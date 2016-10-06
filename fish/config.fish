# Set where to install casks
set -x HOMEBREW_CASK_OPTS "--appdir=/Applications"

# Set default editor
set -gx EDITOR nvim
set -gx GIT_EDITOR nvim

# Remove default fish startup message
set -gx fish_greeting

set -gx FZF_DEFAULT_COMMAND 'ag -g ""'
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

 #Use the diff-so-fancy package (get it with npm)
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

# This is my own experiment
# alias git-overview "find . -maxdepth 1 -mindepth 1 -type d -exec sh -c '(echo {} && cd {} && git status -s && echo)' \;"

# Aliases
abbr --add vim nvim
abbr --add gs 'clear ;and git status -sb'
abbr --add gup 'git stash ;and git pull --rebase ;and git stash apply'
abbr --add gl 'git log --oneline --decorate' # Also shows tags!
abbr --add glog "git log --graph \
            --abbrev-commit \
            --date=relative \
            --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset'"
abbr --add gp 'git push origin HEAD'
abbr --add gd 'git diff'
abbr --add gc 'git commit --verbose'
abbr --add gcm 'git commit -m'
abbr --add gca 'git commit -a'
abbr --add gcam 'git commit -am'
abbr --add gco 'git checkout'
abbr --add gb 'git branch'
abbr --add ga 'git add'

# Set paths for Linuxbrew
if test -d ~/.linuxbrew
  set -gx PATH ~/.linuxbrew/bin $PATH
  set -gx MANPATH ~/.linuxbrew/share/man: MANPATH
  set -gx INFOPATH ~/.linuxbrew/share/info $INFOPATH
end

# added by Miniconda3 4.1.11 installer
# set -gx PATH ~/miniconda3/bin $PATH

if test -d /usr/local/sbin
  set -gx PATH /usr/local/sbin $PATH
end

# Linux set keyboard repeat delay and rate
if type -q xset
  xset r rate 200 20
end

