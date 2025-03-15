# Fish shell

Here are some quick tips for installing and using fish shell on OSX and Linux.

## Install

For OSX:

```
brew install fish
```

or for Ubuntu:

```
sudo add-apt-repository ppa:fish-shell/release-3
sudo apt update
sudo apt upgrade
sudo apt install fish
```

## Change default shell

To finish installing Fish, either follow the instructions in the Terminal or run these:

```
echo '/usr/bin/fish' | sudo tee -a /etc/shells
chsh -s `which fish` # alternative
```

```
echo '/usr/local/bin/fish' | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish
```

## Fisher

Set up [Fisher](https://github.com/jorgebucaran/fisher#install) (plugins for fish)

```
fisher install jorgebucaran/hydro 
```
