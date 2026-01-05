zoxide init fish | source

set -gx EDITOR nvim

# My shortcuts
abbr v "nvim"
abbr gd "git diff"
abbr gco "git checkout"
abbr gs "git status"
abbr gw "git switch"
abbr gm "git commit -m"
abbr -a -g pull "git pull --rebase"
abbr -a -g push "git push"
# abbr t 'tmux attach -t $(tmux ls | fzf --reverse | cut -d: -f1)'

if command -v fzf > /dev/null
  # set -gx FZF_DETAULT_OPTS '--tmux center,60%'
  # set -gx FZF_DEFAULT_OPTS '--height 40% --tmux bottom,40% --layout reverse --border top'
  # TMUX_FZF_OPTIONS="-p -w 62% -h 38% -m"
end

# If `fd` is installed, use it with `fzf`
if command -v fdfind > /dev/null; else if command -v fd > /dev/null
  set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
  set -gx FZF_CTRL_T_COMMAND 'fd --type f --type d --hidden --follow --exclude .git'
  set -gx FZF_CTRL_T_OPTS "
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
  set -gx FZF_ALT_C_COMMAND 'fd --type d --hidden --follow --exclude .git'
else
  echo "fd is missing for nice fzf features"
end

# set path for?
set --export PATH ~/.local/bin $PATH

# linuxbrew (only on Linux)
if test (uname) = "Linux"
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# tmux shortcuts
function fish_user_key_bindings
  # bind \cp 'tmux attach -t $(tmux ls | fzf --reverse | cut -d: -f1)'
  # bind -k f12 'do something'
  bind \e\[24~ 'tmux attach -t $(tmux ls | fzf --reverse | cut -d: -f1)'
end

# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

