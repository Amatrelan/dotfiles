#! /bin/env nu

if "TMUX" in $env {
  return
}

if ((tmux attach | complete | get exit_code) == 1) {
  tmux
}
