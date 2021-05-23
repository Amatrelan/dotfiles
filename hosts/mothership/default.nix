{ pkgs, config, lib, ... }: {
  imports = [ ../home.nix ./hardware-configuration.nix ];

  ## Modules
  modules = {
    desktop = {
      bspwm.enable = true;
      # spectrwm.enable = true;
      apps = {
        discord.enable = true;
        rofi.enable = true;
        godot.enable = true;
        # signal.enable = true;
      };
      browsers = {
        default = "firefox";
        # brave.enable = true;
        firefox.enable = true;
        qutebrowser.enable = true;
      };
      gaming = {
        steam.enable = true;
        # emulators.enable = true;
        # emulators.psx.enable = true;
        emulators.snes.enable = true;
        retroarch.enable = true;
        lutris.enable = true;
      };
      media = {
        # daw.enable = true;
        documents.enable = true;
        graphics.enable = true;
        mpv.enable = true;
        recording.enable = true;
        spotify.enable = true;
      };
      term = {
        default = "xst";
        st.enable = true;
        alacritty.enable = true;
      };
      vm = {
        qemu.enable = true;
        virt-manager.enable = true;
        virtualbox.enable = true;
      };
    };
    dev = {
      rust.enable = true;
      cc.enable = true;
      node.enable = true;
      python.enable = true;
      shell.enable = true;
    };
    editors = {
      default = "nvim";
      emacs.enable = true;
      vim.enable = true;
      vscode.enable = false;
    };
    shell = {
      # adl.enable = true;
      bitwarden.enable = true;
      direnv.enable = true;
      fw.enable = true;
      git.enable = true;
      gnupg.enable = true;
      nnn.enable = true;
      tmux.enable = true;
      zsh.enable = true;
    };
    services = {
      ssh.enable = true;
      # Needed occasionally to help the parental units with PC problems
      # teamviewer.enable = true;
      # transmission.enable = true;
      # docker.enable = false;
      synergy.enable = true;
    };
    theme.active = "alucard";
  };

  ## Local config
  programs.ssh.startAgent = true;
  services.openssh.startWhenNeeded = true;

  networking.networkmanager.enable = true;
  # The global useDHCP flag is deprecated, therefore explicitly set to false
  # here. Per-interface useDHCP will be mandatory in the future, so this
  # generated config replicates the default behaviour.
  networking.useDHCP = false;

  ## Personal backups
  # Syncthing is a bit heavy handed for my needs, so rsync to my NAS instead.
  # systemd = {
  #   services.backups = {
  #     description = "Backup /usr/store to NAS";
  #     wants = [ "usr-drive.mount" ];
  #     path = [ pkgs.rsync ];
  #     environment = {
  #       SRC_DIR = "/usr/store";
  #       DEST_DIR = "/usr/drive";
  #     };
  #     script = ''
  #       rcp() {
  #         if [[ -d "$1" && -d "$2" ]]; then
  #           echo "---- BACKUPING UP $1 TO $2 ----"
  #           rsync -rlptPJ --chmod=go= --delete --delete-after \
  #               --exclude=lost+found/ \
  #               --exclude=@eaDir/ \
  #               --include=.git/ \
  #               --filter=':- .gitignore' \
  #               --filter=':- $XDG_CONFIG_HOME/git/ignore' \
  #               "$1" "$2"
  #         fi
  #       }
  #       rcp "$HOME/projects/" "$DEST_DIR/projects"
  #       rcp "$SRC_DIR/" "$DEST_DIR"
  #     '';
  #     serviceConfig = {
  #       Type = "oneshot";
  #       Nice = 19;
  #       IOSchedulingClass = "idle";
  #       User = config.user.name;
  #       Group = config.user.group;
  #     };
  #   };
  #   timers.backups = {
  #     wantedBy = [ "timers.target" ];
  #     partOf = [ "backups.service" ];
  #     timerConfig.OnCalendar = "*-*-* 00,12:00:00";
  #     timerConfig.Persistent = true;
  #   };
  # };
}
