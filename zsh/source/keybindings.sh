#!/bin/bash

### See $ZDOTDIR/plugins-config/zsh-history-substring-search.sh
# bindkey "^P" up-line-or-beginning-search   # Up
# bindkey "^N" down-line-or-beginning-search # Down
# bindkey "\C-k" previous-history
# bindkey "\C-j" next-history

bindkey '^L' forward-char # Finish completion: echo hi <CR> ech<^L> -> echo hi

bindkey -v
bindkey "^R" history-incremental-pattern-search-backward

tsm_palette() {
  zle -I
  tsm p
  zle reset-prompt
}

zle -N tsm_palette
bindkey '^o' tsm_palette
