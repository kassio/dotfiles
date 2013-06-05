source ~/.dotfiles/my_env
source ~/.dotfiles/aliases

# git
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM=true

build_ps1() {
  local blue='\[\e[0;34m\]'
  local red='\[\e[0;31m\]'
  local yellow='\[\e[01;33m\]'
  local reset='\[\e[00m\]'
  local green='\[\e[0;32m\]'

  local git_ps1="$yellow"$([[ `which __git_ps1` ]] && echo '$(__git_ps1 "(%s)")')
  local pwd_ps1="$blue\w"
  local prompt_ps1="$([[ ${EUID} == 0 ]] && echo $red'#' || echo $green'$')"
  local user_ps1=$([ -e "$home/.user_ps1" ] && cat $home/.user_ps1)

  export PS1="\n$user_ps1$git_ps1$pwd_ps1\n$prompt_ps1$reset "
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

export CLICOLOR=1
LS_COLORS=$(cat <<'COLORS_END'
no=00:
fi=00:
di=00;34:
ln=01;36:
pi=40;33:
so=01;35:
do=01;35:
bd=40;33;01:
cd=40;33;01:
or=40;31;01:
ex=01;32:
*.tar=01;31:
*.tgz=01;31:
*.arj=01;31:
*.taz=01;31:
*.lzh=01;31:
*.zip=01;31:
*.z=01;31:
*.Z=01;31:
*.gz=01;31:
*.bz2=01;31:
*.deb=01;31:
*.rpm=01;31:
*.jar=01;31:
*.jpg=01;35:
*.jpeg=01;35:
*.gif=01;35:
*.bmp=01;35:
*.pbm=01;35:
*.pgm=01;35:
*.ppm=01;35:
*.tga=01;35:
*.xbm=01;35:
*.xpm=01;35:
*.tif=01;35:
*.tiff=01;35:
*.png=01;35:
*.mov=01;35:
*.mpg=01;35:
*.mpeg=01;35:
*.avi=01;35:
*.fli=01;35:
*.gl=01;35:
*.dl=01;35:
*.xcf=01;35:
*.xwd=01;35:
*.ogg=01;35:
*.mp3=01;35:
*.wav=01;35:
COLORS_END
)
export LS_COLORS=$(echo $LS_COLORS | tr -d ' ')

# vim:ft=sh:
