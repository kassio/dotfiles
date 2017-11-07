# dotfiles


## Install

1. Install Xcode (download or App Store);
1. Run:
```console
$ xcode-select --install && \
    sudo xcodebuild -license accept && \
    softwareupdate -ia && \
    git clone https://github.com/kassio/dotfiles.git ~/.dotfiles --recursive && \
    ~/.dotfiles/install/setup
```

### Optional steps

1. Installing my neovim setup
```console
$ ~/.dotfiles/install/setup-nvim
```

## Next steps

1. Open the installed apps (casks) and configure them!
1. Add your ssh keys;
1. Speed up the trackpad;
1. Speed up the key repeat;
1. Make the delay until repeat the shortest;
1. Remove all unecessary OSX shortcuts;
1. Ensure that `All controlls` is select on `Shortcuts` tab of the Keyboard;
1. Disable UI sounds;
