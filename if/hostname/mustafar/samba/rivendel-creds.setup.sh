FILE="/etc/samba/creds/rivendel"
TEMPLATE="$DOTFILES_HOME/if/hostname/korriban/samba/rivendel-creds.template"

generate_rivendel_creds() {
	local password=
	info "setting up rivendel credentials"
	userline "password for rivendel: "
	read -s password
	echo # reset prompt because userline
	info "root necessary to setup rivendel credentials"
	sudo mkdir -p $(dirname "$FILE")
	sed -e "s/\$password/$password/g" "$TEMPLATE" | sudo tee "$FILE" 1>/dev/null
}

[ -L "$FILE" ] && info "root necessary to clean up rivendel credentials" && sudo unlink "$FILE"
[ -f "$FILE" ] || generate_rivendel_creds
