# SSH key agent
if type -q keychain
    keychain --eval --quiet id_ed25519 | source
end

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

# Use vim keybindings in the shell
set --global fish_key_bindings fish_vi_key_bindings

# Prefer the standard executable name; Debian and Ubuntu package it as fdfind.
set -l fd_cmd
if type -q fd
  set fd_cmd fd
else if type -q fdfind
  set fd_cmd fdfind
end

if set -q fd_cmd[1]
  set -gx FZF_DEFAULT_COMMAND "$fd_cmd --type f --hidden --follow --exclude .git"
  set -gx FZF_CTRL_T_COMMAND "$fd_cmd --type f --type d --hidden --follow --exclude .git"
  set -gx FZF_CTRL_T_OPTS "
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
  set -gx FZF_ALT_C_COMMAND "$fd_cmd --type d --hidden --follow --exclude .git"
else
  echo "fd is missing for nice fzf features"
end

# set path for?
set --export PATH ~/.local/bin $PATH

# linuxbrew (only on Linux)
if test (uname) = "Linux"; and test -x /home/linuxbrew/.linuxbrew/bin/brew
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    # eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)"
end
if type -q zoxide
  zoxide init fish | source
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Playwright - use system chromium if available
if command -q chromium-browser
    set -gx PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH /usr/bin/chromium-browser
end

# tmux shortcuts
function fish_user_key_bindings
  # fzf: Ctrl+R history, Ctrl+T files, Alt+C cd
  if command -q fzf
    fzf --fish | source
  end
end

# opencode
fish_add_path $HOME/.opencode/bin

# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end


if test -x "$HOME/.local/bin/mise"
    "$HOME/.local/bin/mise" activate fish | source
else if command -q mise
    mise activate fish | source
end


# Added by LM Studio CLI tool (lms)
set -gx PATH $PATH $HOME/.lmstudio/bin


# Added by Antigravity CLI installer
set -gx PATH "$HOME/.local/bin" $PATH

if test -f $__fish_config_dir/daytona.completion_script.fish
    source $__fish_config_dir/daytona.completion_script.fish
end

