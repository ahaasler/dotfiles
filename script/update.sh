# Update local config in case it's not already loaded
source $HOME/.dotfiles.local

# Variables
args="$@"
debug=false

# Functions
source $DOTFILES_HOME/script/function/log.sh

while getopts ":vdh:" opt; do
	case $opt in
		v|d) debug=true ;;
		:) fail "-$OPTARG requires an argument" ;;
	esac
done

if [ -d "$DOTFILES_HOME/.git" ]; then
	# Git update
	hash git 2>/dev/null || { fail >&2 "git is not installed, please install it"; }
	info 'updating with git'
	(
		cd $DOTFILES_HOME &&
		# Get latest changes
		git pull 2>&1 | while read line; do debug "$line"; done &&
		# Update submodules to latest dotfiles pointer
		git submodule update --init --recursive 2>&1 | while read line; do debug "$line"; done
	)
else
	# Curl update
	hash curl 2>/dev/null || { fail >&2 "curl is not installed, please install it"; }
	info "updating with curl"
	releaseUrl=$(curl -s https://api.github.com/repos/ahaasler/dotfiles/releases | grep browser_download_url | head -n 1 | cut -d '"' -f 4)
	info "downloading latest release: $releaseUrl"
	curl -skL $releaseUrl | tar zx --strip-components 1 -C $DOTFILES_HOME --recursive-unlink
fi

# Update local configuration and read it
bash $DOTFILES_HOME/script/local/update.sh $args
source $HOME/.dotfiles.local

# Setup
bash $DOTFILES_HOME/script/setup.sh $args
