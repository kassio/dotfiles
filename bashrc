export DOTFILES=$HOME/.dotfiles

__build_prompt() {
  local blue='\[\e[0;34m\]'
  local red='\[\e[0;31m\]'
  local yellow='\[\e[01;33m\]'
  local reset='\[\e[00m\]'
  local green='\[\e[0;32m\]'

  local pwd_ps1="$blue\w"
  local tmux_info="${TMUX_PANE:+$red[${TMUX_PANE#\%}]}"

  __git_ps1 "$tmux_info$pwd_ps1$reset" "\\
\n$green\$$reset "
};

# Autocomplete
load_bash_completion() {
  local brew_prefix="`which brew --prefix`"
  local prefix=${brew_prefix:-/usr/local}

  source "/etc/bash_completion" 2>/dev/null
  source "$prefix/etc/bash_completion" 2>/dev/null
  source "$prefix/Library/Contributions/brew_bash_completion.sh" 2>/dev/null
}; load_bash_completion

# Make ** works beautiful, works to any nested directory.
shopt -s globstar

# Append user history
shopt -s histappend

complete -A hostname   rsh rcp telnet rlogin r ftp ping disk
complete -A export     printenv
complete -A variable   export local readonly unset
complete -A enabled    builtin
complete -A alias      alias unalias
complete -A function   function
complete -A user       su mail finger
complete -o default -o nospace -F _rakecomplete rake
complete -o default -o nospace -F _capcomplete cap
complete -o default -o nospace -F _thorcomplete thor

source $DOTFILES/my_env

src() { cd $src/$1; }
_src() {
  local cur
  cur=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $( compgen -S/ -d $src/$cur | cut -b $((${#src}+2))- ) )
}
complete -o nospace -F _src src

__prompt_command() {
  __tmux_notify_status
  __build_prompt
}
export PROMPT_COMMAND=__prompt_command

# vim:ft=sh:
