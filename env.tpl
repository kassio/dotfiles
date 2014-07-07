__custom_prompt_command() {
  __build_prompt # my function to build prompt :)
  export PS1="\[\e[0;31m\]β $PS1" # bashrc
  export PS1="$FG[196]β $PS1" # zsh
}
export PROMPT_COMMAND=__custom_prompt_command #bashrc
precmd_functions=(__custom_prompt_command) #zsh

export $custom="$src/custom"

custom() { cd $custom/$1;  }
_custom() { _files -W $custom -/; }
compdef _custom custom
