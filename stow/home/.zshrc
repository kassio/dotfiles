# vim:ft=zsh:

# global
export DOTFILES="${HOME}/.dotfiles"
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin" # initial base PATH
export EDITOR="nvim"
export GIT_EDITOR="$EDITOR"
export GPG_TTY=$(tty)

export HOMEBREW_PREFIX="$(brew --prefix 2>/dev/null)"
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_BOOTSNAP=1
export HOMEBREW_NO_ENV_HINTS=1
export TERM=xterm-256color-italic

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
source "${DOTFILES}/lib/p10k.cache.zsh" 2>/dev/null # zsh theme

set zle_bracketed_paste  # Explicitly restore this zsh default
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

# load zsh stuff
# load autocomplete modules
FPATH="${HOMEBREW_PREFIX}/share/zsh/site-functions:${FPATH}"
autoload -Uz compinit
if [ $(date +'%j') != $(/usr/bin/stat -f '%Sm' -t '%j' $HOME/.zcompdump) ]; then
  compinit
else
  compinit -C
fi
autoload -Uz bashcompinit && bashcompinit
# Custom completions
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion

# load colors
autoload -Uz colors && colors

# customize the history
export HISTSIZE=120000
export SAVEHIST=100000

# customize the shell
export PROMPT_EOL_MARK="" # Remove % from partial lines
export WORDCHARS="" # Fix the \eb \ef and others.

# easier navigation
CDPATH=".:${HOME}:${HOME}/src"

# style
tabs -2
stty tab2
set tab=2

# options
setopt always_to_end # move cursor to end if word had one match
setopt auto_menu # automatically use menu completion
setopt bang_hist # treat the '!' character specially during expansion.
setopt cd_silent # do not output the path change
setopt complete_in_word
setopt extended_glob # easy regexp on list files (**)
setopt glob_dots # include dotfiles in globbing
setopt hist_expire_dups_first # expire duplicate entries first when trimming history.
setopt hist_find_no_dups # do not display a line previously found.
setopt hist_ignore_all_dups # delete old recorded entry if new entry is a duplicate.
setopt hist_ignore_dups # don't record an entry that was just recorded again.
setopt hist_ignore_space # don't save lines that start with space
setopt hist_no_store # don't save history command on history
setopt hist_reduce_blanks # remove superfluous blanks before recording entry.
setopt hist_save_no_dups # don't write duplicate entries in the history file.
setopt hist_verify # don't execute immediately upon history expansion.
setopt inc_append_history # write to the history file immediately, not when the shell exits.
setopt interactive_comments # don't blow up with comments
setopt prompt_cr # remove % from partial lines
setopt prompt_sp # remove % from partial lines
setopt pushd_silent # do not output the path change
setopt pushd_to_home # pushd without arguments pushd to $HOME
setopt share_history # share history between all sessions.
unsetopt correct # do not correct me
unsetopt correct_all # do not correct me
unsetopt extended_history
unsetopt flow_control
unsetopt hist_ignore_space # ignore space prefixed commands
unsetopt menu_complete # do not navigate completion with arrows

# load libs stuff
source "${HOMEBREW_PREFIX}/opt/asdf/libexec/asdf.sh"
source "${HOMEBREW_PREFIX}/opt/fzf/shell/key-bindings.zsh"
source "${HOME}/.zsh_plugins.sh"

# personal libs
source "${DOTFILES}/lib/bindkeys"
source "${DOTFILES}/lib/alias"
source "${DOTFILES}/lib/fzf"
source "${DOTFILES}/lib/ruby"
source "${DOTFILES}/lib/go"
source "${DOTFILES}/lib/lua"
source "${DOTFILES}/lib/zsh_autosuggest"
source "${DOTFILES}/lib/jq"
source "${DOTFILES}/lib/ulimit"
source "${DOTFILES}/lib/ripgrep"
source "${DOTFILES}/lib/p10k.zsh" 2>/dev/null # zsh theme
source "${DOTFILES}/lib/completions"
source "${HOME}/.dotfiles.private/env" 2>/dev/null # Private stuff
source "${HOME}/.env" 2>/dev/null # Ephemeral stuff

# extend PATH with libs
export PATH="${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin:${PATH}"
export PATH="${HOMEBREW_PREFIX}/opt/python@3.9/bin:${PATH}"
export PATH="${DOTFILES}/bin:${PATH}"
