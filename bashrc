source ~/.dotfiles/my_env
source ~/.dotfiles/aliases

build_ps1() {
  local blue='\[\e[0;34m\]'
  local red='\[\e[0;31m\]'
  local yellow='\[\e[01;33m\]'
  local reset='\[\e[00m\]'
  local green='\[\e[0;32m\]'

  local git_ps1=$yellow'$(__git_ps1 "(%s)")'
  local pwd_ps1="$blue\w"
  local prompt_ps1="$([[ ${EUID} == 0 ]] && echo $red'#' || echo $green'$')"
  local user_ps1=$([ -e "$home/.user_ps1" ] && echo "`cat $home/.user_ps1` ")

  export PS1="\n$user_ps1$pwd_ps1$git_ps1\n$prompt_ps1$reset "
}

build_ps1

# Make ** works beautiful, works to any nested directory.
shopt -s globstar

# Append user history
shopt -s histappend

# Autocomplete
if [[ -n `which brew 2>/dev/null` ]]; then
  if [ -f `brew --prefix`/etc/bash_completion ]; then
    source `brew --prefix`/etc/bash_completion;
    source `brew --prefix`/Library/Contributions/brew_bash_completion.sh;
  fi

  if [ -e "`brew --prefix`/etc/bash_completion.d/password-store" ]; then
    source "`brew --prefix`/etc/bash_completion.d/password-store";
  fi
fi

[ -e /etc/bash_completion ] && source /etc/bash_completion

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

pro() { cd $projects/$1; }

_pro() {
  local cur
  cur=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $( compgen -S/ -d $projects/$cur | cut -b $((${#projects}+2))- ) )
}
complete -o nospace -F _pro pro

asp() { cd $asp/$1; }

_asp() {
  local cur
  cur=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $( compgen -S/ -d $asp/$cur | cut -b $((${#asp}+2))- ) )
}
complete -o nospace -F _asp asp

[ -e "$home/.env" ] && source $home/.env

# vim:ft=sh:
