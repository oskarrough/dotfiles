A collection of configurations for my computers.

Clone the repository to your device,
run the `install.sh` script to symlink.

1. `git clone git@github.com:oskarrough/dotfiles.git <dotfiles-dir>`
2. `cd <dotfiles-dir>`
3. `./install.sh`

> Dropbox is mounted at a different path on *every* machine, so never hardcode it — `install.sh` resolves its own path.

I develop primarily on OSX, Fedora and Windows + WSL. I use the fish shell, neovim and homebrew.

`pi/settings.json` is symlinked to `~/.pi/agent/settings.json`. Everything else in `~/.pi/agent` stays machine-local and is never committed: `auth.json`, `models.json` (local LM Studio and Ollama hosts differ), sessions, skills, agents, extensions.

See [Fedora](fedora.md), [macOS](osx.md), and [Windows](windows.md) setup notes.
