def main [
  --up (-u) # Increase brightness
  --down (-d) # Decrease brightness
] {
  if $up {
    # Write notification someday
    ray increase 5
  }

  if $down {
    ray decrease 5
  }
}

# Directly copy of volume now
# def send_notification [direction: string, volume: int] {
#   let value = "int:value:" + ($volume | into string)
#   notify-send -a "VOLUME" $"($direction) ($volume)%" -h $value -i audio-volume-low-symbolic -r 2593 -u normal
#   canberra-gtk-play -i dialog-error -d "error"
# }
