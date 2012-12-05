# alias
. ~/.bash_aliases

# Meus diretórios e variaveis useful
user=`cat $HOME/.main_user`
[[ $(uname) == 'Darwin' ]] && home="/Users" || home="/home"
export home="$home/$user"
export projects=$home/Projects
export asp=$projects/AutoSeg/Projects

# Forçar a colorização do terminal
force_color_prompt=yes
export TERM=screen-256color

# git
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM=auto

# rbenv
if [ -d "$home/.rbenv" ]; then
  export PATH="$home/.rbenv/bin:/usr/local/sbin:$PATH"
  eval "$(rbenv init -)"

  # rbenv autocomplete
  . "$home/.rbenv/completions/rbenv.bash"

  # prompt with ruby version and arch
  rbv() {
    rbenv_ruby_version=`rbenv version-name`
    rbenv_ruby_arch=`ruby -e 'puts "#{[""].pack("p").size*8}bits"'`
    printf $rbenv_ruby_version"("$rbenv_ruby_arch")\n"
  }
fi

# Visualisação do Console
BLUE='\[\e[1;34m\]'
RED='\[\e[1;31m\]'
YELLOW='\e[1;33m'
WHITE='\[\e[0m\]'
GREEN='\[\e[1;32m\]'

git_ps1=$([[ `which git` ]] && echo '$(__git_ps1 "$YELLOW(%s)")' || echo "")
pwd_ps1="$BLUE\W"
prompt_ps1="$([[ ${EUID} == 0 ]] && echo $RED'#' || echo $GREEN'$')"
[ -f ".user_ps1" -o -h ".user_ps1" ] && user_ps1=`cat .user_ps1`

export PS1="$user_ps1$git_ps1$pwd_ps1$prompt_ps1$WHITE "

# Editor padrao para algumas aplicações
export EDITOR='vim'

# Make ** works beautiful, works to any nested directory.
shopt -s globstar

# Melhorias no histórico
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
HISTCONTROL=ignoreboth

# Tamanho do historico
HISTFILESIZE=10000000000
HISTSIZE=1000000

# Apenda historicos do usuario
shopt -s histappend

# Autocomplete
if [[ -n `which brew 2&>/dev/null` ]]; then
  [ -f `brew --prefix`/etc/bash_completion ] &&
    . `brew --prefix`/etc/bash_completion

  if [ -f "`brew --prefix`/etc/bash_completion.d/password-store" ]; then
    export PASSWORD_STORE_DIR="$home/Dropbox/.password-store"
    . "`brew --prefix`/etc/bash_completion.d/password-store"
  fi
fi

[ -f /etc/bash_completion ] &&
  . /etc/bash_completion

# Melhorias no autocomplete
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

# Colorify less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;37m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Visualização do Console do Mysql
export MYSQL_PS1='\d\$ '

# Force custom bin first
export PATH=$(echo $PATH | sed 's/\/usr\/bin://'):/usr/bin
