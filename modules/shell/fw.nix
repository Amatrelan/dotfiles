{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.shell.fw;
in {
  options.modules.shell.fw = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [ my.fw ];

    modules.shell.zsh.rcInit = ''
      if [[ -x "$(command -v fw)" ]]; then
        if [[ -x "$(command -v fzf)" ]]; then
          eval $(fw print-zsh-setup -f 2>/dev/null);
        else
          eval $(fw print-zsh-setup 2>/dev/null);
        fi;
      fi;'';
  };
}
