# How I like to setup my OSX

After reinstalling OS X, this it how I configure it.

## Install Homebrew and update the system

- Install [Homebrew](http://mxcl.github.com/homebrew/)
- Run `brew install mas` and use `mas` to upgrade your system

## Make keys repeat faster when you hold them down:

```
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
```

## Installing applications with Homebrew cask

Use `brew cask install` to install OS X applications.

`brew cask install firefox iterm2 dropbox visual-studio-code rectangles vlc alfred the_silver_searcher`

## Fish Shell

` brew install fish`

To finish, run this and restart your shell.

```
echo '/usr/local/bin/fish' | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish
```

### FZF and z

1. Install the [Fisher](https://github.com/jorgebucaran/fisher#install) package manager
2. `fisher install z fzf`

With fzf we can use this in the terminal: `ctrl+t`, `ctrl+r` and `alt+c`.
With z we can jump to any directory in our history with fuzzy finding `z downloads`.

## Set up SSH

Without SSH, you'll have to enter your password every time you `git clone`. And that's no fun. 

- Run `ssh-keygen` and follow the steps
- Choose the default filename and give it a passphrase.
- Copy the key with `cat ~/.ssh/id_rsa.pub | pbcopy` and paste it into your accounts on [GitHub](https://github.com/settings/keys) and [GitLab](https://gitlab.com/profile/keys).

## Visual Studio Code

- Enable `vscodevim` plugin
- Add to settings.json

```
"vim.handleKeys": {
  "<C-w>": false,
  "<C-b>": false,
  "<C-f>": false
}
```

## Sublime Text

Install [Package Manager for ST3](https://sublime.wbond.net/installation#st3) by doing `cmd+shift+p` and doing "Install package control". Then install the package "Package Syncing". Then you need to set the sync folder and enable it:

```
Package Syncing: Define… "/Users/oskar/Dropbox/Apps/Sublime Text/sync"
Package Syncing: Enable
```

You might need to restart Sublime a few times to make it work. Check the Sublime console if it's acting weird.

If you installed Sublime using `brew cask` you can ignore this. Otherwise run this line to make it possible to run Sublime from the command line with a `subl` command:

```
ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
```

Vim-mode in Sublime:

- Run `defaults write com.sublimetext.3 ApplePressAndHoldEnabled -bool false` to enable key-repeat
