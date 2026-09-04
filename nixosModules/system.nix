{ lib, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  boot = {
    initrd.systemd.network.wait-online.enable = false;
    loader.efi.canTouchEfiVariables = true;
  };

  systemd.network.wait-online.enable = false;

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
      PATH = [ "${XDG_BIN_HOME}" ];
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

  nix = {
    enable = true;
    settings = {
      substituters = [
        "https://cache.nixos.org"
        "https://doom-emacs-unstraightened.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "doom-emacs-unstraightened.cachix.org-1:O5oOlRPnmQEvVaFyuMTmthCEooHbrg54WgSLR07tmg4="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      experimental-features = [ "nix-command" "flakes" ];
      use-xdg-base-directories = true;
    };
  };
}
