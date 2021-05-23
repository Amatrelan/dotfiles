{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let
  cfg = config.modules.desktop.spectrwm;
  configDir = config.dotfiles.configDir;
in {
  options.modules.desktop.spectrwm = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      lightdm
      dunst
      libnotify
      (polybar.override {
        pulseSupport = true;
        nlSupport = true;
      })
    ];

    services = {
      xserver = {
        enable = true;
        displayManager = {
          defaultSession = "none+spectrwm";
          lightdm.enable = true;
          lightdm.greeters.mini.enable = true;
        };
        windowManager.spectrwm.enable = true;
      };
    };

    systemd.user.services."dunst" = {
      enable = true;
      description = "";
      wantedBy = [ "default.target" ];
      serviceConfig.Restart = "always";
      serviceConfig.RestartSec = 2;
      serviceConfig.ExecStart = "${pkgs.dunst}/bin/dunst";
    };

    # link recursively so other modules can link files in their folders
    home.configFile = {
      "spectrwm".source = "${configDir}/spectrwm";
    };
  };
}
