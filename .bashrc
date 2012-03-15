[[ $- != *i* ]] && return
# alias
. ~/.bash_aliases

# Meus diretórios e variaveis useful
user=kassioborges
export home=/home/$user
export docs=$home/Dropbox
export useful=$home/Useful
export lectures=$docs/Lectures
export know=$home/Knowledge
export college=$docs/College/2011/02
export dev=$home/Development

# Forçar a colorização do terminal
force_color_prompt=yes
export TERM=screen-256color

# Visualisação do Console
export PS1='$(__git_ps1 "(\[\e[1;33m\]%s\[\e[0m\])")\[\033[01;34m\]\W\[\033[00m\]\[\e[032m\]\$\[\e[0m\] '

# git
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM=auto

# Visualização do Console do Mysql
export MYSQL_PS1='\d\$ '

# Editor padrao para algumas aplicações
export EDITOR='vim'

# Permissão de Novos arquivos
umask 027

# Auto-correção ao executar cd
shopt -s cdspell

# Navegar em diretórios utilizando variaveis de ambiente
shopt -s cdable_vars

# Melhorias no histórico
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
HISTCONTROL=ignoreboth

# Tamanho do historico
HISTFILESIZE=10000000000
HISTSIZE=1000000

# Melhoria na busca no histórico
# desativando o stop = ctrl ^S
stty -ixon

# Apenda historicos do usuario
shopt -s histappend

# Verifica o tamanho das janelas para adaptar o tamanho das linhas de comando
shopt -s checkwinsize

# Autocomplete 
. /etc/bash_completion

# Melhorias no autocomplete
set show-all-if-ambiguous on
complete -A hostname   rsh rcp telnet rlogin r ftp ping disk
complete -A export     printenv
complete -A variable   export local readonly unset
complete -A enabled    builtin
complete -A alias      alias unalias
complete -A function   function
complete -A user       su mail finger

# useful
function useful(){
cd "$useful/$1"
}

_useful()
{
  local cur prev opts flist lastword new
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  lastword="${COMP_WORDS[@]: -1}"

  if [[ $lastword =~ / ]]
  then
    new="${lastword##*/}"      # get the part after the slash
    lastword="${lastword%/*}"  # and the part before it
  else
    new="${lastword}"
    lastword=""
  fi

  flist=$( command find $useful/$lastword \
    -maxdepth 1 -mindepth 1 -type d -name "${new}*" \
    -printf "%f\n" 2>/dev/null )

  # if we've built up a path, prefix it to 
  #   the proposed completions: ${var:+val}
  COMPREPLY=( $(compgen ${lastword:+-P"${lastword}/"} \
    -S/ -W "${flist}" -- ${cur##*/}) )
  return 0
}
complete -F _useful -o nospace useful

# Ambiente de desenvolvimento rails
function college(){
cd "$college/$1"
}

_college()
{
  local cur prev opts flist lastword new
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  lastword="${COMP_WORDS[@]: -1}"

  if [[ $lastword =~ / ]]
  then
    new="${lastword##*/}"      # get the part after the slash
    lastword="${lastword%/*}"  # and the part before it
  else
    new="${lastword}"
    lastword=""
  fi

  flist=$( command find $college/$lastword \
    -maxdepth 1 -mindepth 1 -type d -name "${new}*" \
    -printf "%f\n" 2>/dev/null )

  # if we've built up a path, prefix it to 
  #   the proposed completions: ${var:+val}
  COMPREPLY=( $(compgen ${lastword:+-P"${lastword}/"} \
    -S/ -W "${flist}" -- ${cur##*/}) )
  return 0
}
complete -F _college -o nospace college 

# Ambiente de desenvolvimento rails
function dr(){
cd "$dev/$1"
}

_dr()
{
  local cur prev opts flist lastword new
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  lastword="${COMP_WORDS[@]: -1}"

  if [[ $lastword =~ / ]]
  then
    new="${lastword##*/}"      # get the part after the slash
    lastword="${lastword%/*}"  # and the part before it
  else
    new="${lastword}"
    lastword=""
  fi

  flist=$( command find $dev/$lastword \
    -maxdepth 1 -mindepth 1 -type d -name "${new}*" \
    -printf "%f\n" 2>/dev/null )

  # if we've built up a path, prefix it to 
  #   the proposed completions: ${var:+val}
  COMPREPLY=( $(compgen ${lastword:+-P"${lastword}/"} \
    -S/ -W "${flist}" -- ${cur##*/}) )
  return 0
}
complete -F _dr -o nospace dr

complete -o default -o nospace -F _rakecomplete rake
complete -o default -o nospace -F _capcomplete cap
complete -o default -o nospace -F _thorcomplete thor

# Colorify less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;37m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# rbenv
export PATH="$home/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# tmux
[[ $TERM != "screen" ]] && tmux 2&>/dev/null && exit
