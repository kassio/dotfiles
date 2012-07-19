# git
alias "gitl"="git l"
alias "gits"="git s"

# Ls colorido e outro falicitadores de listagem arquivos
alias ls='ls -G'
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
alias psg='ps aux | grep -i '

# Historico de comandos
alias h='history'

# Limpar ambiente latex
alias limpatex='rm -rf *log *aux *nav *out *toc *snm *vrb'

# Ruby e Rails
alias r='rails'
alias be='bundle exec '
