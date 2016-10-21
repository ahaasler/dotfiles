if command -v python >& /dev/null; then
	export DISTRO=$(python -c "import platform;print(platform.linux_distribution()[0])" | tr '[:upper:]' '[:lower:]')
fi
