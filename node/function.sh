# Call pnpm, yarn or npm based on lock file or configuration
node_package_manager() {
	if [ "$1" = 'config' ] || [ "$1" = '--version' ]; then
		command "${NODE_PACKAGE_MANAGER:-npm}" "$@"
		return
	fi
	if [ -f 'pnpm-lock.yaml' ]; then
		echo "Executing 'pnpm $*' because there's a pnpm-lock.yaml file"
		command npx pnpm "$@"
	elif [ -f 'yarn.lock' ]; then
		echo "Executing 'yarn $*' because there's a yarn.lock file"
		command npx yarn "$@"
	elif [ -f 'package-lock.json' ]; then
		echo "Executing 'npm $*' because there's a package-lock.json"
		command npm "$@"
	else
		echo "Executing '${NODE_PACKAGE_MANAGER:-npm} $*' per configuration"
		command npx "${NODE_PACKAGE_MANAGER:-npm}" "$@"
	fi
}
