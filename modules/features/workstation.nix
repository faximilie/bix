{ lib, pkgs, ... }:
{
  programs = {
    nix-index.enable = true;
    neovim.defaultEditor = true;
    solaar = {
      enable = true;
      userService.enable = true;
    };
    uwsm = {
      enable = true;
      waylandCompositors.sway = {
        prettyName = "Sway Nvidia";
        comment = "Sway compositor with --unsuported-gpu managed by UWSM";
        binPath = "/run/current-system/sw/bin/sway";
        extraArgs = [ "--unsupported-gpu" ];
      };
    };
    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
    gamemode.enable = true;
  };

  environment = {
    localBinInPath = true;
    variables = let
      editor = "${lib.getExe pkgs.neovim}";
    in rec {
      XDG_LOCAL_HOME = "$HOME/.local";
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_SRC_HOME = "$HOME/.local/src";
      XDG_STATE_HOME = "$HOME/.local/state";
      XDG_BIN_HOME = "$HOME/.local/bin";
      PATH = [
        "${XDG_BIN_HOME}"
      ];
      EDITOR = editor;
      VISUAL = editor;
      SUDO_EDITOR = editor;
    };

    systemPackages = with pkgs; [
      coreutils
      curl
      wget
      git
      gcc
      gnumake
      libtool
      zip
      unzip
      gnutar
      gnupg
      neovim
      networkmanager
      tailscale
    ];
  };
}
