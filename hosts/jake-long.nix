{ config, lib, options, pkgs, ... }:
lib.optionalAttrs (options ? networking) {
  nixpkgs.config.allowUnfree = true;

  boot = {
    initrd.systemd.network.wait-online.enable = false;
    loader.efi.canTouchEfiVariables = true;
    initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/0c31ce40-15ab-4c5f-b599-b49c21969d34";
    fsType = "btrfs";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/0c31ce40-15ab-4c5f-b599-b49c21969d34";
    fsType = "btrfs";
    options = [ "subvol=home" ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/0c31ce40-15ab-4c5f-b599-b49c21969d34";
    fsType = "btrfs";
    options = [ "subvol=nix" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/CFAD-A6B5";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/340f5bab-3762-4bd8-b5b6-f00e848244e6"; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  networking = {
    hostName = "jake-long";
    networkmanager.enable = true;
    nftables.enable = true;
    firewall = {
      enable = true;
      trustedInterfaces = [ config.services.tailscale.interfaceName ];
      allowedUDPPorts = [ config.services.tailscale.port ];
    };
  };

  systemd = {
    network.wait-online.enable = false;
    services.tailscaled.serviceConfig.Environment = [
      "TS_DEBUG_FIREWALL_MODE=nftables"
    ];
  };

  services = {
    tailscale.enable = true;
    locate = {
      enable = true;
      package = pkgs.plocate;
      interval = "hourly";
      pruneNames = [
        "*.pyc"
        "*.pyo"
        ".DS_Store"
        ".Trash-"
        ".bzr"
        ".cache"
        ".cargo"
        ".class"
        ".git"
        ".hg"
        ".local"
        ".svn"
        ".thumbnail"
        "argo"
        "node_modules"
        "ower_components"
      ];
    };
  };

  programs = {
    nix-index.enable = true;
    solaar = {
      enable = true;
      userService.enable = true;
    };
    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
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

  system.stateVersion = "26.05";
}
