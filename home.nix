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

    # hypr-lua = {
    #     enable = true;
    # 
    #     on.hyprland.start = [
    #       (map (cmd: hypr-lua.lib.exec_cmd "uwsm app -- ${cmd}") [
    #         "waybar"
    #         "hyprpolkitagent"
    #         "org.telegram.desktop.desktop"
    #         "discord.desktop"
    #       ])
    #       # (hl.exec_cmd "uwsm app -- waybar")
    #       # (hl.exec_cmd "uwsm app -- hyprpolkitagent")
    #       # (hl.exec_cmd "uwsm app -- org.telegram.desktop.desktop")
    #       # (hl.exec_cmd "uwsm app -- ")
    #     ];
    # 
    #     bind = let
    #         hl = hypr-lua.lib;
    #         mod = "SUPER";
    #         modShift = "${mod} + SHIFT";
    #       in [
    #           { key = "${modShift} + Q";
    #             handler = hl.dsp.window.close; }
    # 
    #           { key = "${mod} + P";
    #             handler = hl.dsp.exec_cmd "${lib.getExe pkgs.hyprlauncher}"; }
    #           { key = "${modShift} + ESCAPE";
    #             handler = hl.dsp.exit; }
    #           { key = "${mod} + PRINT";
    #             handler = hl.dsp.exec_cmd "${lib.getExe pkgs.sway-contrib.grimshot} copy anything"; }
    #           { key = "${mod} + RETURN";
    #             handler = hl.dsp.exec_cmd "${lib.getExe pkgs.kitty}"; }
    #           { key = "${mod} + SPACE";
    #             handler = hl.dsp.exec_cmd "${lib.getExe pkgs.kitty}"; }
    #           { key = "${modShift} + SPACE";
    #             handler = lib.generators.mkLuaInline "hl.dsp.window.float({ action = 'toggle' })"; }
    #     ]
    #     ++ builtins.concatMap (i: let
    #       nm = if i == 10 then 0 else i;
    #     in [
    #       { key = "${mod} + ${toString nm}";
    #         handler = lib.generators.mkLuaInline "hl.dsp.focus({ workspace = ${toString nm} })"; }
    #       { key = "${modShift} + ${toString nm}";
    #         handler = lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = ${toString nm} })"; }
    #     ]) (builtins.genList (x: x + 1) 10);
    # 
    #     settings = {
    #       mod = {
    #         _var = "SUPER";
    #       };
    #       env = [
    #         { _args = [ "XDG_CURRENT_DESKTOP" "Hyprland" ]; }
    #         { _args = [ "NIXOS_OZONE_WL" "1" ]; }
    #       ];
    #       config.general = {
    #         # gaps_in = 5;
    #         # gaps_out = 20;
    #         # border_size = 2;
    #         col = {
    #           active_border = {
    #             colors = [ "rgba(33ccffee)" "rgba(00ff99ee)" ];
    #             angle = 45;
    #           };
    #           inactive_border = "rgba(595959aa)";
    #         };
    #         resize_on_border = true;
    #         allow_tearing = true;
    #         layout = "dwindle";
    #       };
    #       config.dwindle.preserve_split = true;
    #       config.input = {
    #         kb_layout = "us";
    #         follow_mouse = 1;
    #         touchpad.natural_scroll = false;
    #       };
    #     };
    #   };
    
  };

  

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
    # gaps = {
    #   smartGaps = true;
    # };
  };
}

  # wayland.windowManager.hyprland = {
  #   systemd.enable = false;
  #   enable = true;
  #   settings = {
  #     mod = {
  #       _var = "SUPER";
  #     };
  #   
  #     config = {
  #       general = {
  #         gaps_in = 5;
  #         gaps_out = 20;
  #         border_size = 2;
  #       };
  #   
  #       decoration = {
  #         rounding = 10;
  #       };
  #     };
  #   
  #     bind = [
  #       {
  #         _args = [
  #           (lib.generators.mkLuaInline "mod .. \" + p\"")
  #           (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"${lib.getExe pkgs.hyprlauncher}\")")
  #         ];
  #       }
  #       {
  #         _args = [
  #           (lib.generators.mkLuaInline "mod .. \" + Q\"")
  #           (lib.generators.mkLuaInline "hl.dsp.window.close()")
  #           { locked = true; }
  #         ];
  #       }
  #       {
  #         _args = [
  #           (lib.generators.mkLuaInline "mod .. \" + Print\"")
  #           (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"${lib.getExe pkgs.sway-contrib.grimshot} copy anything\")")
  #         ];
  #       }
  #       {
  #         _args = [
  #           (lib.generators.mkLuaInline "mod .. \" + Space\"")
  #           (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"${lib.getExe pkgs.kitty}\")")
  #         ];
  #       }
  #       {
  #         _args = [
  #           (lib.generators.mkLuaInline "mod .. \" + SHIFT + Space\"")
  #           (lib.generators.mkLuaInline "hl.dsp.window.float({ action = \"toggle\" })")
  #         ];
  #       }
  #       ];
  #     window_rule = {
  #       match.class = "kitty";
  #       border_size = 2;
  #     };
  #   
  #     on = {
  #       _args = [
  #         "hyprland.start"
  #         (lib.generators.mkLuaInline "function()\n  hl.exec_cmd(\"${lib.getExe pkgs.waybar}\")\nend")
  #       ];
  #     };
  #   };
  # };
# ++ (builtins.genList (i:
#        let ws = i + 1;
#        in [
#	  {
#            _args = [
#              (lib.generators.mkLuaInline "mod .. \" + SHIFT + ${toString i}\"")
#              (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = ${toString ws} })")
#            ];
#	  }
#      ]))
#        {
#          _args = [
#            (lib.generators.mkLuaInline "mod .. \" + p\"")
#            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"${lib.getExe pkgs.hyprlauncher}\")")
#          ];
#        }
#        {
#          _args = [
#            (lib.generators.mkLuaInline "mod .. \" + Q\"")
#            (lib.generators.mkLuaInline "hl.dsp.window.close()")
#            { locked = true; }
#          ];
#        }
#        {
#          _args = [
#            (lib.generators.mkLuaInline "mod .. \" + Print\"")
#            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"${lib.getExe pkgs.sway-contrib.grimshot} copy anything\")")
#          ];
#        }
#        {
#          _args = [
#            (lib.generators.mkLuaInline "mod .. \" + Space\"")
#            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"${lib.getExe pkgs.kitty}\")")
#          ];
#        }
#        {
#          _args = [
#            (lib.generators.mkLuaInline "mod .. \" + SHIFT + Space\"")
#            (lib.generators.mkLuaInline "hl.dsp.window.float({ action = \"toggle\" })")
#          ];
#        }
#      ++ builtins.genList (i:
#        let ws = i + 1;
#        in [
#	  {
#            _args = [
#              (lib.generators.mkLuaInline "mod .. \" + SHIFT + ${toString i}\"")
#              (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = ${toString ws} })")
#            ];
#	  }
#          {
#            _args = [
#              (lib.generators.mkLuaInline "mod .. \" + ${toString i}\"")
#              (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = ${toString ws} })")
#            ];
#          }
#	]
#	)
#      )
