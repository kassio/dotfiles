# vim:ft=sh:
# Adding a custom precmd
# First create your __custom_precmd function:
__custom_precmd() {
  __precmd # my precmd function
  export PS1="\[\e[0;31m\]β $PS1" # bashrc
  export PS1="$FG[196]β $PS1" # zsh
}

# To load it in bash:
if [ -z "$PROMPT_COMMAND" ]
then
  PROMPT_COMMAND="__custom_precmd";
else
  PROMPT_COMMAND="$(echo -n ${PROMPT_COMMAND/%; *$//}); __custom_precmd";
fi

# To load it in zsh:
[[ -z $precmd_functions ]] && precmd_functions=()
precmd_functions=($precmd_functions __custom_precmd)

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
