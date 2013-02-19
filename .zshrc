plugins=(git rbenv rails vagrant brew zsh-syntax-highlighting)

ZSH=$HOME/.dotfiles/oh-my-zsh
source $ZSH/oh-my-zsh.sh

source ~/.dotfiles/my_env
###############################################################################

# do not correct me!!
unsetopt correct_all

# I like default grep color
export GREP_COLOR=""

# improve ls colors
export CLICOLOR=1;
export LSCOLORS=exgxfxdxcxegedabagehbh;

# colors on autocomplete
autoload -Uz compinit
compinit
zstyle ':completion:*' list-colors $LSCOLORS

# easy regexp on list files
setopt extendedglob

ZSH_THEME_GIT_PROMPT_ADDED="+"
ZSH_THEME_GIT_PROMPT_AHEAD=">"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DELETED="!"
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_STASHED="$"
ZSH_THEME_GIT_PROMPT_MODIFIED="*"
ZSH_THEME_GIT_PROMPT_PREFIX="$FG[011]("
ZSH_THEME_GIT_PROMPT_RENAMED="~"
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="?"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%%"

git_prompt_info () {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  GIT_STATUS=$(git_prompt_status)
  [[ -n $GIT_STATUS ]] && GIT_STATUS=" $GIT_STATUS"
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$GIT_STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

build_ps1 () {
  local return_code="%(?..$FG[160]%? ↵)%{$reset_color%}";
  local current_dir="$FG[012]%3~";
  local git_branch='$(git_prompt_info)';
  local sign=$([ $UID -eq 0 ] && echo '$FG[160]#' || echo '$FG[046]$');

  export PROMPT="${current_dir}${git_branch}${sign}%{$reset_color%} "
  export RPS1="${return_code}"
}; build_ps1

# autocomplete to my projects
pro() { cd $projects/$1;  }
_pro() { _files -W $projects -/; }
compdef _pro pro

asp() { cd $asp/$1;  }
_asp() { _files -W $asp -/; }
compdef _asp asp
