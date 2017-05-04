gclcd() {
	git clone "$1" && cd "$(basename "$1")"
}
