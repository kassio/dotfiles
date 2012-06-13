# svn
alias rsvnu="svn up; rake db:migrate 2&>/dev/null; rake db:seed 2&>/dev/null; bundle 2&>/dev/null"

# git
alias "gitl"="git log --oneline --decorate=full"
alias "gits"="git status -s -b"

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
alias atualiza='sudo sh -c "aptitude update; aptitude safe-upgrade"'

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
alias rvmd='rvm --default'
alias r='rails'
alias bx='bundle exec '

# Key
alias addkey="sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys "

# Xoom
alias mount_xoom="sudo mtpfs /media/xoom -o allow_other"
alias umount_xoom="sudo fusermount -u /media/xoom"

# mvim
alias vim='mvim -v'
