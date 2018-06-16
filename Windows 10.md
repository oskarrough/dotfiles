# Windows 10 setup

# Bash on Ubuntu on Windows 10

- https://msdn.microsoft.com/en-us/commandline/wsl/install_guide

When in Bash, you can find your Windows drives at `/mnt/c` (where `c` is your drive).  
When in Windows, you can your Ubuntu home folder at `C:\Users\Oskar\AppData\Local\lxss\home` (where `oskar` is your Ubuntu username)

## Fish shell

```
sudo apt-add-repository ppa:fish-shell/release-2
sudo apt-get update
sudo apt-get install fish
```

To finish installing Fish, follow the instructions in the Terminal or run these:

```
echo '/usr/bin/fish' | sudo tee -a /etc/shells
chsh -s /usr/bin/fish
```

Set up [Fisherman.sh](curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher) (plugins for fish)

```
https://github.com/fisherman/fisherman#install
fisher install z fzf
```

## Set up shared SSH keys with Windows 10 + Bash on Ubuntu

Without SSH, you'll have to enter your password every time you `git clone` something which isn't fun.

Run `ssh-keygen` and follow the steps - choose the default filename and give it a passphrase. Next use `cat ~/.ssh/id_rsa.pub | pbcopy` to copy the key and paste it into your accounts on [GitHub](https://github.com/settings/ssh) 

https://daverupert.com/2018/04/developing-on-windows-with-wsl-and-visual-studio-code/

Follow the [GitHub SSH guide](https://github.com/settings/ssh) to generate and add a key from Windows 10 using Git Bash. Afterwards, you'll want the same keys available inside WSL/Bash for Ubuntu on Windows 10. To do this, copy the keys in and fix permissions.

```shell
# Open bash for ubuntu
cp -R /mnt/c/Users/Oskar/.ssh/* ~/.ssh/
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
```

