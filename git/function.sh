gclcd() {
	cmd=git
	hash hub 2>/dev/null && cmd=hub
	$cmd clone "$1" && cd "$(basename "$1" | sed 's/\.git//g')"
}
gd^() {
	git diff $1^ $1 ${@:2}
}
gdt^() {
	git difftool $1^ $1 ${@:2}
}
gtam() {
	git tag -a "$1" -m "$2"
}
