wg_dir="/etc/wireguard"

pubkey_file="$wg_dir/publickey"
prvkey_file="$wg_dir/privatekey"

function wg-get-privatekey() {
    sudo cat "$prvkey_file"
}
function wg-get-publickey() {
    sudo cat "$pubkey_file"
}

wg_connection="wg0"
eth_connection=$(ip route | awk '/default/ {print $5}' | head -n 1)
wg_config_file="$wg_dir/$wg_connection.conf"

function wg-get-config-file() {
    print "$wg_dir/$wg_connection.conf"
}
function wg-read-config() {
    sudo bat "$(wg-get-config-file)"
}
function wg-edit-config() {
    sudo nvim "$(wg-get-config-file)"
}

function wg_m() {
    sudo systemctl "$1" "wg-quick@$wg_connection"
}
function wg-start() {
    wg_m start
}
function wg-stop() {
    wg_m stop
}
function wg-restart() {
    wg_m restart
}
