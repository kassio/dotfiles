alias g="git"
alias gitl="git l"
alias gits="git s"


[[ $(uname) == 'Darwin' ]] && LS_COMMON="-G" || LS_COMMON="--color=auto"
alias ls="ls $LS_COMMON"
alias ll='ls -lh'
alias l='ls -A'
alias la='ls -lhA'

alias ..='cd ..'


[[ $(uname) == 'Darwin' ]] &&
  alias atualiza='brew update && brew upgrade'


alias wiki="vim -c 'call PotwikiHome()'"


export GREP_OPTIONS="--color=auto"


psg() {
  ps aux | grep -i $@ | grep -v grep
}

killer() {
  kill -9 $(psg $@ | awk '{print $2}')
}


alias h='history'


alias r='rails'
alias be='bundle exec '


alias vu='vagrant up'
alias vh='vagrant halt'
alias vr='vagrant reload'
alias vs='vagrant ssh'
alias vus='vagrant up && vagrant ssh'


loop_this() {
  local params=($(echo "$@"))
  local count=${params[0]}
  local command=${params[@]:1};

  for ((i = 0; i < $count; )); do
    echo ">> Build $((++i))";
    echo ">> $command";
    $command
    [[ $? != 0 ]] && break;
    echo "";
  done;
}

# vim:ft=sh:
