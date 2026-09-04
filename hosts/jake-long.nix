{ config, lib, pkgs, ... }:
{
  imports = [
    ../nixosModules/desktop/default.nix
    ../nixosModules/desktop/sway.nix
    ../nixosModules/editor/neovim.nix
    ../nixosModules/indexing.nix
    ../nixosModules/networking.nix
    ../nixosModules/security/secureboot.nix
    ../nixosModules/system.nix
    ../users/faxy.nix
  ];

  boot = {
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
  };

  system.stateVersion = "26.05";
}
