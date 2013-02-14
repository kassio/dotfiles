export home="$home/$user"
export projects=$home/Projects
export asp=$home/AutoSeg/Projects
source ~/.bashrc

ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
plugins=(git git-extras zsh-syntax-highlighting rbenv rails rails3 vagrant brew)

ZSH_THEME_GIT_PROMPT_ADDED="+"
ZSH_THEME_GIT_PROMPT_AHEAD=" >"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DELETED="!"
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_STASHED="$"
ZSH_THEME_GIT_PROMPT_MODIFIED="*"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_RENAMED="~"
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="?"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%%"

function my_git_prompt_info() {
ref=$(git symbolic-ref HEAD 2> /dev/null) || return
GIT_STATUS=$(git_prompt_status)
[[ -n $GIT_STATUS ]] && GIT_STATUS=" $GIT_STATUS"
echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$GIT_STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function build_ps1() {
local return_code="%(?..%{$fg[red]%}%? ↵)%{$reset_color%}";
local current_dir='%{$fg[blue]%}%3~';
local git_branch='$(my_git_prompt_info)';
local sign=$([ $UID -eq 0 ] && echo '%{$fg[red]%}#' || echo '%{$fg[green]%}$');

export PROMPT="${current_dir}${git_branch}${sign}%{$reset_color%} "
export RPS1="${return_code}"
}

build_ps1

asp() { cd $asp/$1;  }
_asp() { _files -W $asp -/; }
compdef _asp asp
