gclcd() {
	git clone "$1" && cd "$(basename "$1" | sed 's/\.git//g')"
}
gd^() {
	git diff $1^ $1
}
gdt^() {
	git difftool $1^ $1
}
