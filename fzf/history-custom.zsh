#!/bin/zsh

# Uses FZF history search if available and if a query has been previously typed
history-custom-up() {
    setopt localoptions noglobsubst noposixbuiltins pipefail 2> /dev/null
    if [ -z "$LBUFFER" ] || [ "$LBUFFER" = "$ZSH_HISTORY_LAST_NON_SEARCH_ENTRY" ]
    then
        history-substring-search-up
        export ZSH_HISTORY_LAST_NON_SEARCH_ENTRY="$LBUFFER"
    else
        type fzf-history-widget &>/dev/null && fzf-history-widget || history-substring-search-up
    fi
}

zle -N history-custom-up
bindkey '^[[A' history-custom-up
