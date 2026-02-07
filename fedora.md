Hey! These are my notes for steps I usually take with a fresh (Fedora) linux install.


INSTALL THESE
  sudo dnf copr enable solopasha/hyprland
  sudo dnf install hyprland fish neovim zoxide git fd-find keepassxc dropbox bat delta-cli
  https://keepassxc.org/download/#linux
  https://sw.kovidgoyal.net/kitty/binary/
  sudo dnf install https://www.dropbox.com/download?dl=packages/fedora/nautilus-dropbox-2025.05.20-1.fc42.x86_64.rpm

> Dropbox needs app indicator support for tray icon, but the tray icon is not really needed. Use `dropbox status` and `dropbox exclude [list]`.
https://www.dropbox.com/install-linux

If in hyprland, setup grimblast for screenshots saving to ~/Dropbox/Screenshots.

Install bluetui for bluetooth.
Use `nmcli radio wifi` for wifi.

