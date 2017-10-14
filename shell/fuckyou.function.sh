# Based on https://gist.github.com/Gargron/9122743
function fuckyou() {
  if [ ! $1 ]; then
    echo "Usage: fuckyou process_name"
    exit
  fi

  if killall $1; then
    echo
    echo " (╯°□°）╯︵$(echo $1 | flip)"
    echo
  fi
}
