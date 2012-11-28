# vi : set=sh :
# git
alias g="git"
alias gitl="git l"
alias gits="git s"

# Ls colorido e outro falicitadores de listagem arquivos
[[ $(uname) == 'Darwin' ]] && LS_COMMON="-G" || LS_COMMON="--color=auto"
alias ls="ls $LS_COMMON"
alias ll='ls -lh'
alias l='ls -A'
alias la='ls -lhA'
alias lt='ls -tA'
alias lta='ls -lthA'

# Facilitador de navegação
alias ..='cd ..'

# Atualização do Sistema
alias atualiza='brew update && brew upgrade'

# Vim com plugin
alias wiki="vim -c 'call PotwikiHome()'"

# Greps
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'

# Processos
psg() {
  ps aux | grep -i $@ | grep -v grep
}

killer() {
  kill -9 $(psg $@ | awk '{print $2}')
}

# Historico de comandos
alias h='history'

# Limpar ambiente latex
alias limpatex='rm -rf *log *aux *nav *out *toc *snm *vrb'

# Ruby e Rails
alias r='rails'
alias be='bundle exec '

# Vagrant
alias vu='vagrant up'
alias vh='vagrant halt'
alias vr='vagrant reload'
alias vs='vagrant ssh'
alias vus='vagrant up && vagrant ssh'
