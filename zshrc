# -*- mode: sh; -*-

setopt interactivecomments

HISTFILE=$HOME/.zsh_history
HISTSIZE=1200
SAVEHIST=1000
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS

fpath+="$HOME/.zfunc"
autoload -Uz compinit && compinit

export CLICOLOR=1
export RUST_BACKTRACE=1
export PROMPT="%F{magenta}%n%F{default} on %F{yellow}$(uname | awk '{ print tolower($0) }')%F{default} %F{magenta}%~%F{default}
%(?..%F{red}%?%F{default} )$ "

chruby_dir="/usr/local/opt/chruby/share/chruby"

if [[ -f "$chruby_dir/chruby.sh" ]]; then
  source "$chruby_dir/chruby.sh"
fi
if [[ -f "$chruby_dir/auto.sh" ]]; then
  source "$chruby_dir/auto.sh"
fi
if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh
fi
if [[ -f /usr/share/fzf/completion.zsh ]]; then
  source /usr/share/fzf/completion.zsh
fi

local opamrc="${HOME}/.opam/opam-init/init.zsh"
if [[ -r "${opamrc}" ]]; then
  source "${opamrc}"
fi

fzf-cd-project() {
  local root="${HOME}/Source"
  local cmd="fd --print0 --color never --hidden --case-sensitive --type directory \\\\A\\\\.git\\|\\\\.pijul\\\\z ${root} 2> /dev/null | xargs -0 -L1 dirname"
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

export FZF_DEFAULT_OPTS="--color=16"

if [ "$(uname -s)" = "Linux" ]; then
  alias ls='ls --color=always'
fi

export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PATH="/usr/local/opt/bash/bin:$PATH"

alias pstree="pstree -g3"

local exa="$(which exa)"
alias ls="${exa} --binary"
alias exa="${exa} --binary --git --long --header --group-directories-first"
