# fish_add_path -g /home/linuxbrew/.linuxbrew/bin

abbr gco "git checkout"
abbr gs "git status"
abbr gw "git switch"
abbr -a -g pull "git pull --rebase"
abbr -a -g push "git push"

# If fd is installed, use it together with FZF.
if command -v fd > /dev/null
  set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
  set -gx FZF_CTRL_T_COMMAND 'fd --type f --type d --hidden --follow --exclude .git'
  set -gx FZF_ALT_C_COMMAND 'fd --type d --hidden --follow --exclude .git'
else
  echo "fd is missing. Run brew install fd"
end


# function gam() { "/Users/oskar/bin/gam/gam" "$@" ; }
# fish_add_path /opt/homebrew/bin
# fish_add_path /opt/homebrew/sbin
# /Applications/Sublime Text.app/Contents/SharedSupport/bin
