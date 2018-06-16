# Set editors
set -gx EDITOR nvim
set -gx GIT_EDITOR vim

# Use Ag by default when using FZF. This is to respect .gitignore and
# search hidden files.
# Also remember: echo /.git/ > ~/.agignore
set -gx FZF_DEFAULT_COMMAND 'ag --hidden -g ""'
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND $dir"
set -U FZF_FIND_FILE_COMMAND "$FZF_DEFAULT_COMMAND"

# Use the diff-so-fancy package (get it with npm)
# git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

set -g fish_user_paths /usr/local/bin $PATH
set -g fish_user_paths ~/.local/bin $PATH

# Aliases
abbr --add ns 'yarn start'
# abbr --add vi 'vim'

# Git aliases
abbr --add gs 'clear ;and git status -sb'
abbr --add gp 'git push origin HEAD'
abbr --add gd 'git diff'
abbr --add gcm 'git commit'
abbr --add gco 'git checkout'
#abbr --add gco "git checkout (git branch | fzf | tr -d ' ')"
abbr --add gb 'git branch'
abbr --add gl 'git log --oneline --decorate' # Also shows tags!
# abbr --add glg "git log --graph --abbrev-commit --date=relative --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset'"

# Linux: set keyboard repeat delay and rate
if type -q xset
	xset r rate 200 20
end

# Linux: Set paths for Linuxbrew
if test -d ~/.linuxbrew
	set -gx PATH ~/.linuxbrew/bin $PATH
	set -gx MANPATH ~/.linuxbrew/share/man: MANPATH
	set -gx INFOPATH ~/.linuxbrew/share/info $INFOPATH
	set -gx XDG_DATA_DIRS ~/.linuxbrew/share: $XDG_DATA_DIRS
end

if test -d /home/user/.linuxbrew
	set -g fish_user_paths "/home/oskar/.linuxbrew/sbin" $fish_user_paths
end

