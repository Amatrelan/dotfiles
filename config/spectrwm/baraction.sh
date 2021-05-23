#!/usr/bin/env bash
# set -euo pipefail

# DATE
dte() {
	dte="$(date +"%A, %B %d %l:%M%p")"

	echo -e "$dte"
}

# DISC
hdd() {
	hdd="$(df -h | awk 'NR==6{print $3, $5}')"
	echo -e "HDD: $hdd"
}

# RAM
mem() {
	mem="$(free | awk '/Mem/ {printf "%d MiB/%d MiB\n", $3 / 1024.0, $2 / 1024.0}')"
	echo -e "MEM: $mem"
}

# CPU
cpu() {
	read cpu a b c previdle rest </proc/stat
	prevtotal=$((a + b + c + previdle))
	sleep 0.5
	read cpu a b c idle rest </proc/stat
	total=$((a + b + c + idle))

	cpu=$((100 * ((total - prevtotal) - (idle - previdle)) / (total - prevtotal)))
	echo -e "CPU: $cpu%"
}

# Audio Volume
vol() {
	vol="$(amixer get Master | awk -F'[][]' 'END{ print $4":"$2 }')"
	echo -e "VOL: $vol"
}

SLEEP_SEC=1
while :; do
	echo "$(cpu) | $(mem) | $(hdd) | $(vol) | $(dte)"
	sleep $SLEEP_SEC
done
