#!/bin/env nu

const tmux_ls_regex = '^(?<id>\w+): (?<windows>\d+) \w+ \(\w+ (?<created_at>.+?)\)(?<attached> \(\w+\)|$)'

def parse_tmux_line [line: string] {
  if ($line | is-empty) {
    return
  }
  mut parsed = $line | parse --regex $tmux_ls_regex

  let created_at = $parsed.created_at | first | into datetime
  $parsed.created_at = $created_at

  let attached = $parsed.attached | str contains "attached" | first
  $parsed.attached = $attached
  $parsed
}

def main [
  --attach (-a) # attachs on first no attached
  --first (-f) # Returns first non attached
  --ls (-l) # Lists all tmux sessions
] {
  let tmux_ls = (tmux ls | lines)
  
  let a = $tmux_ls | each { |it| 
    parse_tmux_line $it
  } | flatten

  if $first or $attach {
    let val = $a | where attached == false
    if $first {
      return $val
    }

    if ($val | is-empty) {
      tmux new
    } else {
      tmux attach -t $val.id
    }
  }

  if $ls {
    $a
  }
}

use std assert

#[test]
def test_parsing [] {
  let tmux_ls = "0: 1 windows (created Thu Nov 30 15:19:07 2023) (attached)"

  let out = parse_tmux_line $tmux_ls

  assert equal $out.id ["0"]
  assert equal $out.windows ["1"]
  assert equal $out.created_at [2023-11-30T15:19:07+02:00]
  assert equal $out.attached [true]
}
