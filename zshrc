export PROMPT="%F{magenta}%n%F{default} on %F{yellow}$(uname | awk '{ print tolower($0) }')%F{default} %F{magenta}%~%F{default}
%(?..%F{red}%?%F{default} )$ "
export TERM=xterm
[[ -s $HOME/.zshrc.local ]] && source "$HOME/.zshrc.local"

setopt interactivecomments

HISTFILE=$HOME/.zsh_history
setopt APPEND_HISTORY
HISTSIZE=1200
SAVEHIST=1000
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY
autoload -Uz compinit && compinit
export CLICOLOR=1

if [[ -f /usr/share/chruby/chruby.sh ]]; then
  source /usr/share/chruby/chruby.sh
fi

export RUST_BACKTRACE=1

if [ "$(uname -s)" = "Linux" ]; then
  alias ls='ls --color=always'
fi
