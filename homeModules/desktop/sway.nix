{ lib, pkgs, ... }:
{
  programs.waybar.enable = true;
  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;
    wrapperFeatures.gtk = true;
    config = with pkgs; with lib; let
      modifier = "Mod4";
      terminal = "${getExe wezterm}";
      launcher = "${getExe raffi}";
      grimshot = "${getExe sway-contrib.grimshot} copy anything";
    in {
      inherit modifier terminal;
      startup = [
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
        "${modifier}+Shift+q" = "kill";
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
