alias update-dotfiles="$DOTFILES_HOME/script/update.sh"
hash ud 2>/dev/null || alias ud=update-dotfiles
alias udd='update-dotfiles -d; srcd'
alias srcd='source ~/.profile'
