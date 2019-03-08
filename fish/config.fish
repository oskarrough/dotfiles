# Set editors
set -gx EDITOR nvim
set -gx GIT_EDITOR vim

# Set paths
set -g fish_user_paths "/usr/local/opt/postgresql@10/bin" $fish_user_paths
set -g fish_user_paths /usr/local/bin $PATH
set -g fish_user_paths ~/.local/bin $PATH
set -g fish_user_paths ~/.cargo/bin $PATH

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

# Aliases

# Use Ag by default when using FZF. This is to respect .gitignore and
# search hidden files.
# Also remember: echo .git/ > ~/.agignore
set -gx FZF_DEFAULT_COMMAND 'ag --hidden --ignore .git -g ""'
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND $dir"
set -gx FZF_CD_COMMAND "fd --type directory"
set -U FZF_FIND_FILE_COMMAND "$FZF_DEFAULT_COMMAND"
# set -gx FZF_CTRL_T_OPTS "--select-1 --exit-0"
# set -gx FZF_ALT_C_OPTS "--preview 'tree -C {} | head -200'"

# -a means add
abbr -a e 'nvim'
abbr -a gs 'clear ;and git status -sb'
abbr -a gp 'git push origin HEAD'
abbr -a gd 'git diff'
abbr -a gcm 'git commit'
abbr -a gco 'git checkout'
abbr -a gl 'git log --oneline --decorate' # Also shows tags!
abbr -a ns 'yarn start'
# abbr -a gb 'git branch'
#abbr -a gco "git checkout (git branch | fzf | tr -d ' ')"

