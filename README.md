# How I like to setup my OSX

After reinstalling OS X, here's what I normally do to configure it for personal use focused on development.

## 1. Software

Before anything, run Apple Software Update, update everything and install Xcode. While it's happening, do this:

- Stop Apple from spying: [fix-macosx.com](https://fix-macosx.com/)
- Disable mouse acceleration: [smoothmouse.com](http://smoothmouse.com) or [Steel Series Exact Mouse Tool](http://downloads.steelseriescdn.com/drivers/tools/steelseries-exactmouse-tool.dmg)

And set keyboard repeat to as fast as possible in the System Preferences.

## 2. Homebrew and Fish

- Install [Homebrew](http://mxcl.github.com/homebrew/). Then:

```
brew doctor
brew install git node fish
fish
set fish_greeting
```

To finish installing Fish, follow the instructions in the Terminal or run these:

```
echo '/usr/local/bin/fish' | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish
```

If you want some colors, check [iterm2colorschemes.com](http://iterm2colorschemes.com).

## Installing applications with Homebrew cask

- Install [Homebrew cask](http://caskroom.io/) by running `brew install caskroom/cask/brew-cask`.

Then follow this pattern to install stuff:

`brew cask install alfred iterm2 sublime-text3 google-chrome dropbox 1password vlc`

Remember to setup Dropbox sync with Alfred, iTerm and 1password.

## Install some more "essential" stuff

```
sudo gem update --system
sudo gem install git-up
n latest
npm i -g npm@latest
npm install -g bower gulp-cli ember-cli surge trash-cli empty-trash-cli n xo release-it browser-sync
```

## Set up SSH

Without SSH, you'll have to enter your password every time you `git clone` something which isn't fun. So run `ssh-keygen` and follow the steps - choose the default filename and give it a passphrase. Next use `cat ~/.ssh/id_rsa.pub | pbcopy` to copy the key and paste it into your accounts on [GitHub](https://github.com/settings/ssh) and [Bitbucket](https://bitbucket.org/account/user/oskarrough/ssh-keys/).

### Configure Sublime Text

Install [Package Manager for ST3](https://sublime.wbond.net/installation#st3) and install the package "Package Syncing". Then you need to set the sync folder and enable it:

```
Package Syncing: Define… "/Users/oskar/Dropbox/Apps/Sublime Text/sync"
Package Syncing: Enable
```

You might need to restart Sublime a few times to make it work. Check the Sublime console if it's acting weird.

If you installed Sublime using `brew cask` you can ignore this. Otherwise run this line to make it possible to run Sublime from the command line with a `subl` command:

```
ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
```

And this one as well to use Sublime for `git commit`:

```
git config --global core.editor " '/usr/local/bin/subl' -n -w"
```
