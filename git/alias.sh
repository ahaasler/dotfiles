alias gi=git
alias many=git
alias much=git
alias such=git
alias very=git
alias gc='git commit'
alias gca='gc -a'
alias gcm='gc -m'
alias gcam='gca -m'
alias gcma='gcam'
alias gcaa='gc --allow-empty --amend'
alias ga='git add'
alias gaa='ga --all'
alias gap='ga -p'
alias gaap='gaa -p'
alias gapa='gaap'
alias gl='git log'
alias gll='gl -1'
alias gl1='gll'
alias gl2='gl -2'
alias gl3='gl -3'
alias gl4='gl -4'
alias gl5='gl -5'
alias gl6='gl -6'
alias gl7='gl -7'
alias gl8='gl -8'
alias gl9='gl -9'
alias gln='gl -n'
alias gla='gl @{u}..HEAD'
alias glls='gll --skip'
alias gllc='gll --pretty=%B'
alias gllsc='gll --pretty=%B --skip'
alias gllcs='gllsc'
alias glg='gl --grep'
alias glme='gl --author "$(git config user.name)"'
alias glt='gl --tags --simplify-by-decoration --pretty="format:%ai %C(bold yellow)%D"'
alias gsl='git show -1'
alias gsa='git show @{u}..HEAD'
alias gps='git push'
alias gpst='gps --tags'
alias gpl='git pull --rebase'
alias gco='git checkout'
alias gcom='gco master'
alias gcod='gco develop'
alias gcob='gco -b'
alias gcp='git cherry-pick'
alias gs='git status'
alias gsp='git stash pop'
alias gss='git stash save'
alias gsls='git stash list'
alias gd='git diff'
alias gdc='gd --cached'
alias gdl='gd HEAD^ HEAD'
alias gda='gd @{u} HEAD'
alias gdp='gd pom.xml'
alias gdt='git difftool'
alias gdtm='gdt --tool meld'
alias gdtc='gdt --cached'
alias gdtmc='gdtm --cached'
alias gdtcm='gdtmc'
alias gdtl='git difftool HEAD^ HEAD'
alias gdtml='gdtm HEAD^ HEAD'
alias gdtlm='gdtml'
alias grs='git reset'
alias grb='git rebase'
alias grbc='grb --continue'
alias grba='grb --abort'
alias grbm='grb master'
alias grbd='grb develop'
alias gmg='git merge'
alias gmgm='gmg master'
alias gmgd='gmg develop'
alias gmgt='git mergetool'
alias gcl='git clone'
