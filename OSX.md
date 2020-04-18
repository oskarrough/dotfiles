# How I like to setup my OSX

After reinstalling OS X, this it how I configure it.

Run Apple Software Update and update everything.

Make keys repeat faster when you hold them down:

```
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
```

## 2. Homebrew and Fish

- Install [Homebrew](http://mxcl.github.com/homebrew/). Then:

```
brew doctor
brew install git fish yarn mas
```

To change the default shell to use Fish, run this and afterwards restart your shell.

```
echo '/usr/local/bin/fish' | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish
```

Optionally install [Fisherman.sh](https://github.com/fisherman/fisherman#install) (fish package manager) and a few plugins

```
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
https://github.com/fisherman/fisherman#install
fisher install z fzf
```

## Installing applications with Homebrew cask

Use `brew cask install` to install OS X applications.

`brew cask install firefox dropbox iterm2 sublime-text3 visual-studio-code rectangles vlc alfred the_silver_searcher`

Remember to setup Alfred and iTerm to use my Dropbox sync.

## Set up SSH

Without SSH, you'll have to enter your password every time you `git clone` something which isn't fun. So run `ssh-keygen` and follow the steps - choose the default filename and give it a passphrase. Next use `cat ~/.ssh/id_rsa.pub | pbcopy` to copy the key and paste it into your accounts on [GitHub](https://github.com/settings/keys) and [GitLab](https://gitlab.com/profile/keys).

### Configure Sublime Text

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

### FZF

ctrl+t
ctrl+r
alt+c
