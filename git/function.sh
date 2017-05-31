gclcd() {
	git clone "$1" && cd "$(basename "$1" | sed 's/\.git//g')"
}
gd^() {
	git diff $1^ $1
}
