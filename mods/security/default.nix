{ config, lib, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.sbctl
  ];

  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
    measuredBoot = {
      enable = false;
      pkiBundle = "/var/lib/sbctl";
      pcrs = [
        0 # platform-code: Changes on firmware updates
        1 # platform-config: Changes on basic harware changes
        2 # external-code: Option ROMs on pluggable hardware firmware
        3 # external-config: information abouy pluggable hardware firmware
        4 # boot-loader-code: Changes on boot loader updates
        # 5 # boot-loader-config: Changes when partitions are changed
        7 # secure-boot-policy: Changes on SecureBoot and PK/KEK/db/dbx changes

        # 10 #ima: paranoid linux, one day
        # 11 # kernel-boot: measures ELF kernel images, etc,
        # 12 # kernel-config: Meaasures kernel command-line, fixes init=/bin/sh
      ];
    };
    #configurationLimit = 8;
    autoGenerateKeys.enable = true;
    autoEnrollKeys = {
      enable = true;
      # Automatically reboot to enroll the keys in the firmware
      autoReboot = true;
    };
  };
  security =  {
  	polkit.enable = true;
    rtkit.enable = true;
    isolate.enable = true;
    soteria.enable = true;
  };
}
