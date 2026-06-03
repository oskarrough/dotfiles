# Windows 10 setup

Raycast is an easy way to set up shortcuts like alt+shift+b for browser.

## Tiling

Config is in /mnt/c/Users/oskar/.config

```
winget install LGUG2Z.komorebi
winget install LGUG2Z.whkd
komorebi stop --whkd --bar
winget upgrade LGUG2Z.komorebi
```

## WSL 

- https://learn.microsoft.com/windows/wsl/install

When in Bash, you can find your Windows drives at `/mnt/c` (where `c` is your drive).  
From Windows, open a distribution's home directory at `\\wsl$\Distro\home\username`.

## Set up SSH in WSL

Generate a separate key inside WSL rather than copying a private key from Windows:

```shell
ssh-keygen -t ed25519
cat ~/.ssh/id_ed25519.pub
```

Add the public key to [GitHub](https://github.com/settings/ssh).

## FZF and more goodies

```shell
https://github.com/sharkdp/fd?tab=readme-ov-file#installation
wget https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-v10.2.0-x86_64-unknown-linux-gnu.tar.gz
tar xzf ...
mv folder/fd ~./local/bin
```

## Newest node

```shell
# Add the latest LTS to apt
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt install node
```
