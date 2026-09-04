{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (aspellWithDicts (dicts: with dicts; [ en en-computers en-science ]))
    bolt-launcher xivlauncher steam-run lutris sway-contrib.grimshot
    fastfetch pwvucontrol broot cachix keepassxc raffi telegram-desktop
    signal-desktop
  ];

  programs = {
    readline = {
      enable = true;
      variables = {
        editing-mode = "vi";
        show-all-if-ambiguous = true;
        completion-ignore-case = true;
      };
    };
    neovide.enable = true;
    neovim.enable = true;
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
    librewolf.enable = true;
    bash.enable = true;
    fd.enable = true;
    jq.enable = true;
    jqp.enable = true;
  };
}
