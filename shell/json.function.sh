json-sort() {
	if [ $# -eq 0 ]; then in="sys.stdin"; else in="open('$1')"; fi
	python -c "import json, sys; json.dump(json.load($in), sys.stdout, indent=2, sort_keys=True)"
}

json-vimdiff() {
	vimdiff <(json-sort $1) <(json-sort $2)
}
