
# If fd is installed, use it together with FZF.
if command -v fd > /dev/null
  set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
  set -gx FZF_CTRL_T_COMMAND 'fd --type f --type d --hidden --follow --exclude .git'
  set -gx FZF_ALT_C_COMMAND 'fd --type d --hidden --follow --exclude .git'
end

