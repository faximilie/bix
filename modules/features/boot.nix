{ ... }:
{
  boot = {
    initrd.systemd.network.wait-online.enable = false;
    loader.efi.canTouchEfiVariables = true;
  };

  systemd.network.wait-online.enable = false;
}
