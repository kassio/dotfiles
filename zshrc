export DOTFILES=$HOME/.dotfiles
export ZSH=$DOTFILES/oh-my-zsh
export DISABLE_AUTO_TITLE=true # fix command echo in some terminal emmulators

plugins=(gitfast rbenv vagrant brew vundle colored-man heroku)
source $ZSH/oh-my-zsh.sh

for plugin in `ls $DOTFILES/zsh-plugins`
do
  source $DOTFILES/zsh-plugins/$plugin/*plugin.zsh
done

# Fix to use tmux, rbenv and zsh
if [ -x /usr/libexec/path_helper ]; then
  PATH=""
  eval `/usr/libexec/path_helper -s`
fi

source $DOTFILES/my_env
source $DOTFILES/aliases
source $DOTFILES/zprompt

# do not correct me!!
unsetopt correct_all
unsetopt correct

# I like default grep color
export GREP_COLOR=""

# colors on autocomplete
autoload -Uz compinit
compinit
zstyle ':completion:*' list-colors $LSCOLORS

# easy regexp on list files
setopt extendedglob

# autocomplete to my projects
pro() { cd $projects/$1;  }
_pro() { _files -W $projects -/; }
compdef _pro pro

asp() { cd $asp/$1;  }
_asp() { _files -W $asp -/; }
compdef _asp asp

# vim:ft=zsh:
