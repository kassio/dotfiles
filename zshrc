# Fix to use tmux, rbenv and zsh
if [ -x /usr/libexec/path_helper ]
then
  PATH=""
  eval `/usr/libexec/path_helper -s`
fi

export DOTFILES=$HOME/.dotfiles
export DISABLE_AUTO_TITLE=true # fix command echo in some terminal emmulators
export DISABLE_AUTO_UPDATE=true

source $DOTFILES/lib/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $DOTFILES/lib/spectrum.zsh

brew_prefix=`which brew --prefix`
prefix=${brew_prefix:-/usr/local}
brew_completion="$prefix/Library/Contributions/brew_zsh_completion.sh"
if [[ -e $brew_completion ]]
then
  source $brew_completion
fi

## Completions
autoload -U compinit
compinit -C

## case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*' matcher-list \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# do not correct me!!
unsetopt correct_all
unsetopt correct

## History
HISTFILE=$HOME/.zhistory       # enable history saving on shell exit
setopt APPEND_HISTORY          # append rather than overwrite history file.
HISTSIZE=1200                  # lines of history to maintain memory
SAVEHIST=1000                  # lines of history to maintain in history file.
setopt HIST_EXPIRE_DUPS_FIRST  # allow dups, but expire old ones when I hit HISTSIZE
setopt EXTENDED_HISTORY        # save timestamp and runtime information

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

__build_prompt() {
  local tmux_info="${TMUX_PANE:+$FG[196][${TMUX_PANE#\%}]}";
  local current_dir="$FG[004]%~"

  __git_ps1 "${tmux_info}${current_dir} %f" "
$FG[002]$%f " "(%s)"
}

__build_rprompt() {
  local return_code="%(?..$FG[160]%? ↵)%f";
  export RPS1="${return_code}"
}; __build_rprompt

__prompt_command() {
  __tmux_notify_status
  __build_prompt
}
precmd_functions=(__prompt_command)

source $DOTFILES/my_env

# vim:ft=zsh:
