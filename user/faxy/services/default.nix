{ ... }:
{
  services = {
    syncthing = {
      enable = true;
      tray.enable = true;
    };
    tailscale-systray.enable = true;
    emacs.enable = true;
  };
}
