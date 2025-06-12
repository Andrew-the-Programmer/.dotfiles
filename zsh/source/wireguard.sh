wg_dir="/etc/wireguard"

pubkey_file="$wg_dir/publickey"
prvkey_file="$wg_dir/privatekey"

function wg-get-privatekey() {
    sudo cat "$prvkey_file"
}
function wg-get-publickey() {
    sudo cat "$pubkey_file"
}

wg_connection=""
eth_connection=$(ip route | awk '/default/ {print $5}' | head -n 1)
wg_config_file="$wg_dir/$wg_connection.conf"

function wg-select-connection() {
    connections=$(sudo find "$wg_dir" -maxdepth 1 -type f -name "*.conf" -printf "%f\n" | sed 's/\.conf$//')
    wg_connection=$(
        print "$connections" |
            fzf --preview "sudo bat --style=numbers --color=always --line-range :500 $wg_dir/{}.conf" --prompt="Select wg connection: "
    )
}

function wg-get-connection() {
    if [ -z "$wg_connection" ]; then
        wg-select-connection
    fi
    print "$wg_connection"
}

function wg-get-config-file() {
    print "$wg_dir/$(wg-get-connection).conf"
}

function wg-read-config() {
    sudo bat "$(wg-get-config-file)"
}
function wg-edit-config() {
    sudo nvim "$(wg-get-config-file)"
}

function wg_m() {
    sudo systemctl "$1" "wg-quick@$(wg-get-connection)"
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
