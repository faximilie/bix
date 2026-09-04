{ lib, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.sbctl
  ];

  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
    enable = true;
    measuredBoot = {
      enable = false;
      pcrs = [
        0
        1
        2
        3
        4
        7
      ];
    };
    pkiBundle = "/var/lib/sbctl";
    autoGenerateKeys.enable = true;
    autoEnrollKeys = {
      enable = true;
      autoReboot = true;
    };
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
    isolate.enable = true;
    soteria.enable = true;
  };
}
