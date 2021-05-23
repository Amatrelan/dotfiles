{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.gaming.retroarch;
in {
  options.modules.desktop.gaming.retroarch = with types; {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs;
      [
        # a
        retroarch
      ];
  };
}
