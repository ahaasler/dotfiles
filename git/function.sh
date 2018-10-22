gclcd() {
	gcl "$1" && cd "$(basename "$1" | sed 's/\.git//g')"
}
gd^() {
	gd $1^ $1 ${@:2}
}
gdt^() {
	gdt $1^ $1 ${@:2}
}
gtam() {
	gta "$1" -m "$2"
}
