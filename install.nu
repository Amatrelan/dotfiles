# Simple wrapper script where I collect all things I need installed
# orignal plan was to implement this in rust for rotten but still here
def main [
  --dryrun (-d) # Dryrun to see what is installed
] {
  check_and_install_paru false

  let core_list: list = [
    "kitty"
    "mako"
    "libnotify"
    "neovim"
    "pamixer"
    "ripgrep"
    "swayidle"
    "waybar"
    "wlsunset"
    "zellij"
  ]

  let command = $'paru -S --needed ($core_list | str join " ")'
  run $command $dryrun
}

def check_and_install_paru [dryrun: bool] {
  let paru_installed = not (paru -V | is-empty)
  if $paru_installed {
    return
  }

  run "git clone https://aur.archlinux.org/paru.git /tmp/paru_install" $dryrun
  run "cd /tmp/paru_install; makepkg -si" $dryrun
}

def run [command, dryrun: bool] {
  print $"Running command ($command)"
  if not $dryrun {
    nu -c $command
  }
}
