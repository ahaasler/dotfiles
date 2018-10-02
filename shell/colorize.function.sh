colorize() {
	substitutions=''
	while getopts ":r:g:y:b:p:c:w:" opt; do
		case $opt in
			r) substitutions+=";s^$OPTARG^\x1b[1;31m&\x1b[0m^g" ;;
			g) substitutions+=";s^$OPTARG^\x1b[1;32m&\x1b[0m^g" ;;
			y) substitutions+=";s^$OPTARG^\x1b[1;33m&\x1b[0m^g" ;;
			b) substitutions+=";s^$OPTARG^\x1b[1;34m&\x1b[0m^g" ;;
			p) substitutions+=";s^$OPTARG^\x1b[1;35m&\x1b[0m^g" ;;
			c) substitutions+=";s^$OPTARG^\x1b[1;36m&\x1b[0m^g" ;;
			w) substitutions+=";s^$OPTARG^\x1b[1;37m&\x1b[0m^g" ;;
			:) echo "-$OPTARG requires an argument" ;;
		esac
	done
	sed "$substitutions"
}
