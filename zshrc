# -*- mode: sh; -*-

setopt interactivecomments

HISTFILE=$HOME/.zsh_history
HISTSIZE=1200
SAVEHIST=1000
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt EXTENDED_HISTORY

fpath+="$HOME/.zfunc"
autoload -Uz compinit && compinit

export CLICOLOR=1
export RUST_BACKTRACE=1
export PROMPT="%F{magenta}%n%F{default} on %F{yellow}$(uname | awk '{ print tolower($0) }')%F{default} %F{magenta}%~%F{default}
%(?..%F{red}%?%F{default} )$ "

if [[ -f /usr/share/chruby/chruby.sh ]]; then
  source /usr/share/chruby/chruby.sh
fi
if [[ -f /usr/share/chruby/auto.sh ]]; then
  source /usr/share/chruby/auto.sh
fi
if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh
fi
if [[ -f /usr/share/fzf/completion.zsh ]]; then
  source /usr/share/fzf/completion.zsh
fi

fzf-cd-project() {
  local root="${HOME}/Source"
  local cmd="fd --print0 --color never --hidden --case-sensitive --type directory \\\\A\\\\.git\\\\z ${root} 2> /dev/null | xargs -0 -L1 dirname"
  setopt localoptions pipefail 2> /dev/null
  local dir="$(eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS" fzf +m)"
  if [[ -z "$dir" ]]; then
    zle redisplay
    return 0
  fi
  cd "$dir"
  local ret=$?
  zle reset-prompt
  return $ret
}
zle -N fzf-cd-project
bindkey '\ep' fzf-cd-project

if [ "$(uname -s)" = "Linux" ]; then
  alias ls='ls --color=always'
fi
