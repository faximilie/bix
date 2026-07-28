{ config, lib, pkgs, ... }:

{
  imports = [
  ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "faxy";
    homeDirectory = "/home/faxy";
    preferXdgDirectories = true;
    stateVersion = "26.05";
    packages = with pkgs; [
        sway-contrib.grimshot
        fastfetch
        telegram-desktop
        bolt-launcher
        discord
      ];
  };




  services = {
    hyprlauncher.enable = false;
    tailscale-systray.enable = true;
    emacs.enable = false;
  };
  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;


    waybar.enable = true;

    emacs.enable = true;
    

    afew.enable = true;
    khal.enable = true;
    khard.enable = true;
    wezterm = {
      enable = true;
      enableBashIntegration = true;
    };

    yazi = {
      enable = true;
      enableBashIntegration = true;
    };

    freetube.enable = true;
    discord.enable = true;
    firefox.enable = true;
    

    bash = {
      enable = true;
    };

    fd.enable = true;
    jq.enable = true;
    jqp.enable = true;


  wayland.windowManager.sway = {
    enable = true;
    systemd = {
      enable = true;
      dbusImplementation = config.services.dbus.implementation or "broker";
    };
    wrapperFeatures.gtk = true;
    config = with lib; let e = p: { __functor = _: a: "${getExe p} ${toString a}"; __toString =
 _: getExe p; }; in with pkgs; rec {
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "${lib.getExe pkgs.wezterm}";
      startup = [
        # Launch Firefox on start
        { command = "firefox"; }
      ];
    };
  };
}

