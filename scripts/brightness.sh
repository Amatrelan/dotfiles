#!/bin/sh
down() {
	/home/ama/.cargo/bin/ray decrease 5
}

up() {
	/home/ama/.cargo/bin/ray increase 5
}

case "$1" in
	up) up;;
	down) down;;
esac
