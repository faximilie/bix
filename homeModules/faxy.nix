{ pkgs, ... }:
{
  home = {
    username = "faxy";
    homeDirectory = "/home/faxy";
    stateVersion = "26.05";
    packages = with pkgs; [
      (aspellWithDicts (dicts: with dicts; [ en en-computers en-science ]))
      bolt-launcher
      xivlauncher
      steam-run
      lutris
      sway-contrib.grimshot
      fastfetch
      pwvucontrol
      broot
      cachix
      keepassxc
      raffi
      telegram-desktop
      signal-desktop
    ];
  };

  services = {
    syncthing = {
      enable = true;
      tray.enable = true;
    };
    tailscale-systray.enable = true;
  };

  programs = {
    afew.enable = true;
    khal.enable = true;
    khard.enable = true;
    freetube.enable = true;
    discord.enable = true;
    librewolf.enable = true;
  };
}
