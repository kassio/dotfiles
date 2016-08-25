# vim:ft=sh:
__custom_precmd() {
  __precmd # my precmd function
  export PS1="\[\e[0;31m\]β $PS1" # bashrc
  export PS1="$FG[196]β $PS1" # zsh
}
export PROMPT_COMMAND=__custom_precmd #bashrc
precmd_functions=(__custom_precmd) #zsh

export $custom="$src/custom"

custom() { cd $custom/$1;  }
_custom() { _files -W $custom -/; }
compdef _custom custom

# personal paths
projects_path="$HOME/Code"
private_projects="$projects_path/private"
for project in $(find $private_projects -type d -depth 1 2>/dev/null); do
  export CDPATH="$CDPATH:$project"
done
export CDPATH="$CDPATH:$private_projects"
export CDPATH="$CDPATH:$projects_path"
