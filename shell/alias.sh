alias s=sudo
alias fucking=sudo
alias bd='cd $OLDPWD'
alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias .6='cd ../../../../../..'
alias .7='cd ../../../../../../..'
alias .8='cd ../../../../../../../..'
alias .9='cd ../../../../../../../../..'
alias ..2='.2'
alias ..3='.3'
alias ..4='.4'
alias ..5='.5'
alias ..6='.6'
alias ..7='.7'
alias ..8='.8'
alias ..9='.9'
alias ls='ls --color=auto'
alias l='ls -lh'
alias ll='l -a'
alias l.='l -d .*'
alias grep='grep --color=auto'
alias egrep='grep -E'
alias fgrep='grep -F'
alias man='LC_ALL=C LANG=C man'
alias dus='du -hsc -- * | sort -h'
hash colordiff 2>/dev/null && alias diff=colordiff
alias fd='find . -type d -name'
alias ff='find . -type f -name'
alias mkdir='mkdir -pv'
alias myip='curl -skL http://ipecho.net/plain; echo'
alias sha1='openssl sha1'
alias mnt='mount | column -t'
alias k='kill -9'
