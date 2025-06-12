wg_dir="/etc/wireguard"

pubkey_file="$wg_dir/publickey"
prvkey_file="$wg_dir/privatekey"

function wg_get_privatekey() {
    sudo cat "$prvkey_file"
}
function wg_get_publickey() {
    sudo cat "$pubkey_file"
}

wg_connection="wg0"
eth_connection=$(ip route | awk '/default/ {print $5}' | head -n 1)
wg_config_file="$wg_dir/$wg_connection.conf"

function wg_read_config() {
    sudo bat "$wg_config_file"
}
function wg_edit_config() {
    sudo nvim "$wg_config_file"
}

function wg_m() {
    sudo systemctl "$1" "wg-quick@$wg_connection"
}
function wg_start() {
    wg_m start
}
function wg_stop() {
    wg_m stop
}
function wg_restart() {
    wg_m restart
}
