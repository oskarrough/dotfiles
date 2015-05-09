# Rough OS X - How I like to configure my OS

A personal checklist I follow when installing a fresh OS X.

## 1. Software

Run Apple Software Update, wait for it to install and restart.

Stop Apple from spying and disable mouse acceleration:

- [fix-macosx.com](https://fix-macosx.com/)
- [smoothmouse.com](http://smoothmouse.com)


## 2. System stuff

[Install Homebrew](http://mxcl.github.com/homebrew/). It'll also ask you to install some xcode tools which you should let it do. When it's done, do:

```BASH
brew doctor
brew install node
```

## Installing OS X applications

To install apps without downloading and tedious mouse dragging, we can install using [Homebrew cask](http://caskroom.io/):

`brew install caskroom/cask/brew-cask`

Then follow this pattern to install something:

`brew cask install sublime-text`

## Configure Sublime Text

Install [Package Manager for ST3](https://sublime.wbond.net/installation#st3).

**Sync settings through Dropbox:**

Install the package [Package Syncing](https://packagecontrol.io/packages/Package%20Syncing). Then you need to set the sync folder and enable it:

```
Package Syncing: Define… "Dropbox/Apps/Sublime Text/sync"
Package Syncing: Enable
```

You probably need to restart Sublime to make it work. Check the Sublime console if it's acting weird.

**Make it possible to use Sublime from the Terminal with a `subl` command:**

```
ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
```

## Installing Fish prompt

Remember to follow the instructions brew gives you in the Terminal after running this command:

`brew install fish`

## Install some more essential stuff:

```
sudo gem update --system
sudo gem install bundler
npm install -g bower gulp ember-cli grunt-cli surge
```

## More software

If you're clever, you install these using cask.

- [iTerm](https://iterm2.com/downloads.html)
- [Dropbox](https://www.dropbox.com/downloading)
- [1Password](https://agilebits.com/onepassword/mac)
- [Sublime Text 3](http://www.sublimetext.com/3)
- [Transmit](http://panic.com/transmit/)
- [VLC](http://www.videolan.org/vlc/index.html)
- [Transmission](http://www.transmissionbt.com/download/)
- [Kaleidoscope](http://kaleidoscopeapp.com)
- [Google Chrome](https://www.google.com/intl/en/chrome/browser/)
- [Firefox](http://www.mozilla.org/en-US/firefox/new/)
