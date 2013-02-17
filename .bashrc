source ~/.dotfiles/my_env

# git
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM=true

build_ps1() {
  local blue="$(tput setaf 12)"
  local red="$(tput setaf 160)"
  local yellow="$(tput setaf 11)"
  local white="$(tput setaf 7)"
  local green="$(tput setaf 46)"

  local git_ps1=$([[ `which git` ]] && echo "$yellow"'$(__git_ps1 "(%s)")' || echo "")
  local pwd_ps1="$blue\W"
  local prompt_ps1="$([[ ${EUID} == 0 ]] && echo $red'#' || echo $green'$')"
  [ -e "$home/.user_ps1" ] && user_ps1=`cat $home/.user_ps1`

  export PS1="$user_ps1$git_ps1$pwd_ps1$prompt_ps1$white "
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
    export PASSWORD_STORE_DIR="$home/Dropbox/.password-store";
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
