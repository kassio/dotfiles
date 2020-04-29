# dotfiles

## Install

```console
git clone https://github.com/kassio/dotfiles.git ~/.dotfiles &&
  ~/.dotfiles/bin/install-dotfiles
```

## Manual Steps

Enable “Always open links of this type” on Chrome and Brave.
```console
defaults write "com.brave.Browser" ExternalProtocolDialogShowAlwaysOpenCheckbox -bool true
defaults write "com.google.Chrome" ExternalProtocolDialogShowAlwaysOpenCheckbox -bool true
```
