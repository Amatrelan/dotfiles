{ config, options, lib, pkgs, inputs, ... }:

with lib;
with lib.my;
let cfg = config.modules.editors.vscode;
in {
  options.modules.editors.vscode = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable { user.packages = with pkgs; [ vscode ]; };
}
