# How I like to setup my OSX

## 1. Software

Run Apple Software Update. Then install these:

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

Stop Apple from spying:

- [fix-macosx.com](https://fix-macosx.com/)

Disable mouse acceleration:

- [smoothmouse.com](http://smoothmouse.com)

## 2. Configure Sublime Text

Install [Package Manager for ST3](https://sublime.wbond.net/installation#st3)
Install the package "Package Syncing". Then you need to set the sync folder and enable it:

```
Package Syncing: Define… "Dropbox/Apps/Sublime Text/sync"
Package Syncing: Enable
```

You might need to restart Sublime a few times to make it work. Check the Sublime console if it's acting weird.

Make it possible to use Sublime from the Terminal with a `subl` command:

```
ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
```

## 3. System stuff

First [install Homebrew](http://mxcl.github.com/homebrew/). It'll also ask you to install some xcode stuff which you should let it do. Then do:

```
brew doctor
brew install node
brew install fish
```

To finish installing Fish, follow the instructions brew gives you in the Terminal.

## Installing OS X applications

To install apps without downloading and dragging them manually, we can install [Homebrew cask](http://caskroom.io/):

`brew install caskroom/cask/brew-cask`

Then follow this pattern to install stuff:

`brew cask install google-chrome`

## Install some more essential stuff:

```
sudo gem update --system
sudo gem install bundler
npm install -g bower gulp ember-cli grunt-cli
```
