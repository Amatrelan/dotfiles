#!/bin/env nu

def main [] {
  let ps_contains = ps | where name =~ "wlsunset"
  if not ($ps_contains | is-empty) {
    return
  }

  ^wlsunset -l 60.2 -L 24.9 
}
