{ pkgs, config, lib, ... }:

{
  imports = [
  ];

  xdg.desktopEntries.emacsclient = {
    name = "Emacs (Client)";
    genericName = "Text Editor";
    comment = "Edit text";
    mimeType = [
      "text/english" "text/plain" "text/x-makefile" "text/x-c++hdr" 
      "text/x-c++src" "text/x-chdr" "text/x-csrc" "text/x-java" 
      "text/x-moc" "text/x-pascal" "text/x-tcl" "text/x-tex" 
      "application/x-shellscript" "text/x-c" "text/x-c++"
    ];
    # Simplifies the command to avoid broken nested quoting string parsing
    exec = "emacsclient -n -c %F";
    icon = "emacs";
    terminal = false;
    type = "Application";
    categories = [ "Development" "TextEditor" ];
  };

  home = {
    username = "faxy";
    homeDirectory = "/home/faxy";
    preferXdgDirectories = true;
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
    tailscale-systray.enable = true;
    emacs.enable = true;
  };
  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    doom-emacs.enable = true;


    waybar.enable = true;

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
  };


  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;
    wrapperFeatures.gtk = true;
    # config = with lib; let e = p: { __functor = _: a: "${getExe p} ${toString a}"; __toString = _: getExe p; }; in with pkgs; rec {
    config = with pkgs; with lib; let
      modifier = "Mod4";
      terminal = "${getExe wezterm}";
      launcher = "${getExe raffi}";
      grimshot = "${getExe sway-contrib.grimshot} copy anything";
    in {
      modifier = modifier;
      terminal = terminal;
      startup = [
        # Launch Firefox on start
        { command = "firefox"; }
      ];
      keybindings = {
        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+p" = "exec ${launcher}";

        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";
        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";

        "${modifier}+Shift+c" = "fullscreen";
        "${modifier}+space" = "floating toggle";
        "${modifier}+Shift+space" = "sticky toggle";

        "${modifier}+Print" = "exec ${grimshot}";
      } // lists.foldr (x: y: x // y) {} (map
          (i: {
            "${modifier}+${toString i}" = "exec 'swaymsg workspace ${toString i}'";
            "${modifier}+Shift+${toString i}" = "exec 'swaymsg move container to workspace ${toString i}'";
          })
        (lib.range 0 9));
    };
  };
}

