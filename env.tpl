export PS1="$FG[196]Δ$PS1" # zsh
export PS1="\[\e[0;31m\]β$PS1" # bashrc

export $custom="$src/custom"

custom() { cd $custom/$1;  }
_custom() { _files -W $custom -/; }
compdef _custom custom
