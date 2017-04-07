vpn() {
	sudo systemctl start openvpn-client@$1
}

vpnstop() {
	sudo systemctl stop openvpn-client@$1
}
