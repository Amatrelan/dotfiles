{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.shell.nnn;
in {
  options.modules.shell.nnn = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable { user.packages = with pkgs; [ nnn ]; };
}
