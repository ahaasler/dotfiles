colorize() {
	color=37
	if [ "$1" = "red" ]
	then
		color=31
	elif [ "$1" = "green" ]
	then
		color=32
	elif [ "$1" = "yellow" ]
	then
		color=33
	elif [ "$1" = "blue" ]
	then
		color=34
	elif [ "$1" = "purple" ]
	then
		color=35
	elif [ "$1" = "cyan" ]
	then
		color=36
	fi
        sed "s^$2^\x1b[1;${color}m&\x1b[0m^g"
}
