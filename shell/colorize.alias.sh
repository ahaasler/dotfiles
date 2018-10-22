alias red='colorize -r'
alias green='colorize -g'
alias yellow='colorize -y'
alias blue='colorize -b'
alias purple='colorize -p'
alias cyan='colorize -c'
alias white='colorize -w'

# Author: Dennis Kaarsemaker (https://unix.stackexchange.com/a/55547)
# License: cc by-sa 3.0 (licenses/cc-by-sa-3.0.txt)
alias uncolorize='sed -r "s/\x1B\[[0-9;]*[JKmsu]//g"'
alias nocolor='uncolorize'
