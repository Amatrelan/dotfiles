{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let
  cfg = config.modules.services.synergy;
in {
  options.modules.services.synergy = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [ barrier ];

    networking.firewall.allowedTCPPorts = [ 8081 ];
  };
}
