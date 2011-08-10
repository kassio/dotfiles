# Meus diretórios e variaveis useful
user=kassioborges
export home=/home/$user
export docs=$home/Dropbox
export useful=$home/Useful
export lecture=$docs/Lectures
export know=$home/Knowledge
export college=$docs/College/2011/02
export dev=$docs/Development

# Forçar a colorização do terminal
force_color_prompt=yes

# Visualisação do Console
export PS1='$(__git_ps1 "(%s)")\[\033[01;34m\]\W\[\033[00m\]\[\e[032m\]\$\[\e[0m\] '

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

# Load Colors
 test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

# Altera titulo do terminal
function xtitle(){
    case "$TERM" in
        *term | rxvt)
            echo -n -e "\033]0;$*\007" ;;
        *)  
            ;;
    esac
}

# Função para mudar o titulo da janela com qnd executa o 'man'
function man(){
		xtitle The \'$(basename $1|tr -d .[:digit:])\' manual
		command man "$1"
    xtitle Terminal
}

function upservices(){
	for serv in "$@"; do
		sudo service $serv start	
	done
}

function downservices(){
	for serv in "$@"; do
		sudo service $serv stop
	done
}

# Aucomplete do upservices e downservices
_servicecomplete(){
		COMPREPLY=($(compgen -W "` rcconf -l | awk '{print $1}'`" -- ${COMP_WORDS[COMP_CWORD]}))
}

complete -o default -o nospace -F _servicecomplete upservices
complete -o default -o nospace -F _servicecomplete downservices

# Atalho para mudar o titulo da janela quando executa o htop
 alias htop="xtitle Htop; htop; xtitle Terminal"

# Auto-correção ao executar cd
shopt -s cdspell

# Melhorias no histórico
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
HISTCONTROL=ignoreboth

# Tamanho do historico
HISTFILESIZE=10000000000
HISTSIZE=1000000

# Apenda historicos do usuario
shopt -s histappend

# Verifica o tamanho das janelas para adaptar o tamanho das linhas de comando
shopt -s checkwinsize

# Facilita copia de arquivos ocultos
shopt -s dotglob
shopt -s extglob

# Autocomplete 
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Melhorias no autocomplete
set show-all-if-ambiguous on
complete -A hostname   rsh rcp telnet rlogin r ftp ping disk
complete -A export     printenv
complete -A variable   export local readonly unset
complete -A enabled    builtin
complete -A alias      alias unalias
complete -A function   function
complete -A user       su mail finger

export COMP_WORDBREAKS=${COMP_WORDBREAKS/\:/}

_rakecomplete() {
  COMPREPLY=($(compgen -W "`rake -s -T 2>/dev/null | awk '{{print $2}}'`" -- ${COMP_WORDS[COMP_CWORD]}))
  return 0
}

_capcomplete() {
  COMPREPLY=($(compgen -W "`cap  -T  2>/dev/null| awk '{{ if ( $3 ~ /\#/ ) print $2}}'`" -- ${COMP_WORDS[COMP_CWORD]}))
  return 0
}

_thorcomplete() {
  COMPREPLY=($(compgen -W "`THOR_COLUMNS=1000 thor -T 2>/dev/null| awk '{{ if ( $2 ~ /./ ) print $2}}'`" -- ${COMP_WORDS[COMP_CWORD]}))
  return 0
}

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

#rvm
 [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
 [[ -r "$HOME/.rvm/scriptscompletion" ]] && source "$HOME/.rvm/scripts/completion"

# alias
. ~/.bash_aliases
