export EDITOR=vi
hash vim 2>/dev/null && export EDITOR=vim
hash gvim 2>/dev/null && export EDITOR='gvim -v'
hash vimx 2>/dev/null && export EDITOR=vimx
export VISUAL="$EDITOR"
