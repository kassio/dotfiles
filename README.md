dotfiles
========

Install
-------

      git clone https://github.com/kassio/dotfiles.git ~/.dotfiles --recursive
      ~/.dotfiles/install/setup

Setup Github token with osxkeychain
-----------------------------------

      printf "protocol=https\nhost=github.com\nusername=%s\npassword=%s\n" \
        "<<GITHUB_USER>>" "<<GITHUB_TOKEN>" | git credential-osxkeychain store
