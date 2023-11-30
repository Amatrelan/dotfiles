#!/bin/env nu

use std

def main [
  --up (-u) # Volume Up
  --down (-d) # Volume Down
  --mute (-m) # Toggle mute
] {
  if $up {
    pamixer -i 5
    let volume = pamixer --get-volume | into int
    send_notification "Increasing" $volume
  }
  if $down {
    pamixer -d 5
    let volume = pamixer --get-volume | into int
    send_notification "Decreasing" $volume
  }

  if $mute {
    let muted = pamixer --get-mute | into bool
    print $muted
    if $muted {
      pamixer -u
      let volume = pamixer --get-volume | into int
      send_notification "UNMUTED" $volume
    } else {
      pamixer -m
      let volume = pamixer --get-volume | into int
      send_notification "MUTED" $volume
    }
  }
}

def send_notification [direction: string, volume: int] {
  let value = "int:value:" + ($volume | into string)
  notify-send -a "VOLUME" $"($direction) ($volume)%" -h $value -i audio-volume-low-symbolic -r 2593 -u normal
  canberra-gtk-play -i dialog-error -d "error"
}
