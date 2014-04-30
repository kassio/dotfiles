# Fix to use tmux, rbenv and zsh
if [ -x /usr/libexec/path_helper ]
then
  PATH=""
  eval `/usr/libexec/path_helper -s`
fi

export DOTFILES=$HOME/.dotfiles
export ZSH=$DOTFILES/oh-my-zsh
export DISABLE_AUTO_TITLE=true # fix command echo in some terminal emmulators

plugins=(rbenv brew heroku)
source $ZSH/oh-my-zsh.sh

source $DOTFILES/lib/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

brew_prefix=`which brew --prefix`
prefix=${brew_prefix:-/usr/local}
brew_completion="$prefix/Library/Contributions/brew_zsh_completion.sh"
if [[ -e $brew_completion ]]
then
  source $brew_completion
fi

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

# don't blow up with comments
setopt interactive_comments

source $DOTFILES/my_env
source $DOTFILES/zprompt

src() { cd $src/$1;  }
_src() { _files -W $src -/; }
compdef _src src

precmd_functions=(__tmux_notify_status)

# vim:ft=zsh:
