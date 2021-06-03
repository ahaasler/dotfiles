FILE="/etc/samba/creds/nas"
TEMPLATE="$DOTFILES_HOME/if/hostname/mustafar/samba/nas-creds.template"

generate_nas_creds() {
	local password=
	info "setting up nas credentials"
	userline "password for nas: "
	read -s password
	echo # reset prompt because userline
	local escaped_password
	escaped_password=$(printf '%s\n' "$password" | sed -e 's/[\/&]/\\&/g')
	info "root necessary to setup nas credentials"
	sudo mkdir -p $(dirname "$FILE")
	sed -e "s/\$password/${escaped_password}/g" "$TEMPLATE" | sudo tee "$FILE" 1>/dev/null
}

[ -L "$FILE" ] && info "root necessary to clean up nas credentials" && sudo unlink "$FILE"
[ -f "$FILE" ] && [ "$(head -n 1 "$FILE")" = "$(head -n 1 "$TEMPLATE")" ] || generate_nas_creds
