set --universal nvm_default_version "latest"

zoxide init fish | source

abbr gd "git diff"
abbr gco "git checkout"
abbr gs "git status"
abbr gw "git switch"
abbr gm "git commit -m"
abbr -a -g pull "git pull --rebase"
abbr -a -g push "git push"

# If fd is installed, use it together with FZF.
if command -v fd > /dev/null
  set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
  set -gx FZF_CTRL_T_COMMAND 'fd --type f --type d --hidden --follow --exclude .git'
  set -gx FZF_ALT_C_COMMAND 'fd --type d --hidden --follow --exclude .git'
else
  echo "fd is missing for nice fzf features"
end

# Bun
# set --export BUN_INSTALL "$HOME/.bun"
# set --export PATH $BUN_INSTALL/bin $PATH


# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
