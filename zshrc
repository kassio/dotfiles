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

__build_prompt() {
  local tmux_info="${TMUX_PANE:+$FG[196][${TMUX_PANE#\%}]}";
  local current_dir="$FG[027]%~"

  __git_ps1 "${tmux_info}${current_dir}%{$reset_color%}" "%s
$FG[046]$ "
}

__build_rprompt() {
  local return_code="%(?..$FG[160]%? ↵)%{$reset_color%}";
  export RPS1="${return_code}"
}; __build_rprompt

__prompt_command() {
  __tmux_notify_status
  __build_prompt
}
precmd_functions=(__prompt_command)

source $DOTFILES/my_env

# vim:ft=zsh:
