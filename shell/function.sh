mkcd() {
	mkdir -p -- "$1" && cd -- "$1"
}

f() {
	file="$1"
	shift
	if [ "$#" = "0" ]; then
		set "."
	fi
	for d in "$@"; do
		find "$d" -iname "*$file*"
		shift
	done
}

# http://owen.cymru/sf-a-quick-way-to-search-for-some-thing-in-bash-and-edit-it-with-vim-2/
sf() {
	if [ "$#" -lt 1 ]; then echo "Supply string to search for!"; return 1; fi
	printf -v search "%q" "$*"
	include="yml,js,json,php,md,styl,pug,jade,html,config,py,cpp,c,go,hs,rb,conf,fa,lst,java,groovy"
	exclude=".config,.git,node_modules,vendor,build,yarn.lock,*.sty,*.bst,*.coffee,dist"
	rg_command='rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always" -g "*.{'$include'}" -g "!{'$exclude'}/*"'
	files=`eval $rg_command $search | fzf --ansi --multi --reverse | awk -F ':' '{print $1":"$2":"$3}'`
	[[ -n "$files" ]] && ${EDITOR:-vim} $files
}
