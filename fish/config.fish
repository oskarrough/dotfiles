# Set editors
set -gx EDITOR nvim
set -gx GIT_EDITOR vim

# Fix some Catalina bug
set -gx LC_ALL en_GB.UTF-8 

# Set paths
# set -g fish_user_paths "/usr/local/opt/postgresql@10/bin" $fish_user_paths
# set -g fish_user_paths /usr/local/bin $fish_user_paths
# set -g fish_user_paths /usr/local/sbin $fish_user_paths
# set -g fish_user_paths ~/.local/bin $fish_user_paths
# set -g fish_user_paths ~/Library/Python/3.7/bin $fish_user_paths

# FZF

# On Ubuntu, fd is called fdfind, so...
# https://github.com/sharkdp/fd
# https://github.com/BurntSushi/ripgrep
if type -q "fdfind"
	alias fd="fdfind" 
end

# Use fd (https://github.com/sharkdp/fd) instead of the default find with FZF
set -gx FZF_DEFAULT_COMMAND "fd --hidden --follow --exclude .git --type f"
set -gx FZF_CTRL_T_COMMAND 	"fd --hidden --follow --exclude .git --type f --type d"
set -gx FZF_ALT_C_COMMAND 	"fd --hidden --follow --exclude .git --type d"

# set -gx FZF_DEFAULT_OPTS "--layout=reverse --inline-info"
# set -gx FZF_CD_COMMAND "fd --hidden --type directory"

# Add preview to ctrl+t command
# also autoselect if 1 result, autoexit if 0.
set -gx FZF_CTRL_T_OPTS "--select-1 --exit-0 --preview 'head -100 {}'"

# Add preview with folder contents using tree to alt+c command.
# also autoselect if 1 result, autoexit if 0.
# set -gx FZF_ALT_C_OPTS "--select-1 --exit-0 --preview 'tree -C {} | head -200'"

function fco -d "Fuzzy-find and checkout a branch"
  git branch --all | grep -v HEAD | string trim | fzf | read -l result; and git checkout "$result"
end

function fcoc -d "Fuzzy-find and checkout a commit"
  git log --pretty=oneline --abbrev-commit --reverse | fzf --tac +s -e | awk '{print $1;}' | read -l result; and git checkout "$result"
end

function note -d "Fuzzy-find my personal notes"
	nvim 'fd . ~/Notes | fzf --select-1 --preview "head -200 {}"'
	#ag ~/Notes | fzf --select-1 --preview "head -200 {}"
end


# Aliases
# -a means add
abbr -a e 'nvim'
abbr -a gs 'clear ;and git status -sb'
abbr -a gp 'git push origin HEAD'
abbr -a gd 'git diff'
abbr -a gcm 'git commit'
abbr -a gco 'git checkout'
abbr -a switch 'git switch'
abbr -a pull 'git pull'
abbr -a zgco "git checkout (git branch | fzf | tr -d ' ')"
abbr -a gl 'git log --oneline --decorate' # Also shows tags!
abbr -a ns 'yarn start'
abbr -a l 'exa'
# abbr -a gb 'git branch'

# Linux: Set paths for Linuxbrew
# if test -d /home/linuxbrew/
# 	set -x HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
# 	set -x HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar"
# 	set -x HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew"
# 	set -g fish_user_paths /home/linuxbrew/.linuxbrew/bin $fish_user_paths
# 	set -g fish_user_paths /home/linuxbrew/.linuxbrew/sbin $fish_user_paths
# end
# if test -d /home/user/.linuxbrew
# 	set -g fish_user_paths "/home/oskar/.linuxbrew/bin" $fish_user_paths
# end

# rbenv
# status --is-interactive; and source (rbenv init -|psub)
