awk -F'=' '/^ID=/ {print tolower($2)}' /etc/*-release
