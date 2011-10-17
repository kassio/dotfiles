# svn
alias rsvnu="svn up; rake db:migrate 2&>/dev/null; rake db:seed 2&>/dev/null; bundle 2&>/dev/null"

# git
alias "gitl"="git log --oneline --decorate=full"
alias "gits"="git status -s -b"

# Ls colorido e outro falicitadores de listagem arquivos
alias ls='ls --color=auto'
alias ll='ls -lh'
alias l='ls -A'
alias la='ls -lhA'
alias lt='ls -tA'
alias lta='ls -lthA'

# Facilitador de navegação
alias ..='cd ..'

# Atualização do Sistema
alias atualiza='sudo sh -c "aptitude update; aptitude safe-upgrade"'

# Vim com plugin
alias wiki="vim -c 'call PotwikiHome()'"

# Greps
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
export GREP_OPTIONS=" --exclude-dir=\.svn --exclude *swp,*swo"

# Processos
alias psg='ps aux | grep -i '

# Historico de comandos
alias h='history'

# Limpar ambiente latex
alias limpatex='rm -rf *log *aux *nav *out *toc *snm *vrb'

# Ruby e Rails
alias rvmd='rvm --default'
alias r='rails'
alias bx='bundle exec rake'

# Key
alias addkey="sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys "
