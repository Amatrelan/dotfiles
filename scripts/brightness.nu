#!/bin/env nu

def main [
  --up (-u) # Increase brightness
  --down (-d) # Decrease brightness
  --amount (-a) = 10 # Amount of change
] {
  if $up {
    # Write notification someday
    /home/ama/.cargo/bin/ray increase $amount
  }

  if $down {
    /home/ama/.cargo/bin/ray decrease $amount
  }
}

# Directly copy of volume now
# def send_notification [direction: string, volume: int] {
#   let value = "int:value:" + ($volume | into string)
#   notify-send -a "VOLUME" $"($direction) ($volume)%" -h $value -i audio-volume-low-symbolic -r 2593 -u normal
#   canberra-gtk-play -i dialog-error -d "error"
# }
