# Windows 10 setup

# Bash on Ubuntu on Windows 10/11

- https://msdn.microsoft.com/en-us/commandline/wsl/install_guide

Make sure to use WSL2 (and not 1) before installing Linux. See https://docs.microsoft.com/en-us/windows/wsl/install-win10#update-to-wsl-2

When in Bash, you can find your Windows drives at `/mnt/c` (where `c` is your drive).  
When in Windows, you can your Ubuntu home folder at `C:\Users\Oskar\AppData\Local\lxss\home` (where `oskar` is your Ubuntu username)

## Set up shared SSH keys with Windows and WSL/Ubuntu

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

## FZF and more goodies

https://github.com/sharkdp/fd?tab=readme-ov-file#installation
wget https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-v10.2.0-x86_64-unknown-linux-gnu.tar.gz
tar xzf ...
mv folder/fd ~./local/bin