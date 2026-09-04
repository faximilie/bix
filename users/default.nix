{ lib, options, ... }:
lib.optionalAttrs (options ? home) {
  home.preferXdgDirectories = true;

  programs = {
    home-manager.enable = true;
    readline = {
      enable = true;
      variables = {
        editing-mode = "vi";
        show-all-if-ambiguous = true;
        completion-ignore-case = true;
      };
    };
    bash.enable = true;
    fd.enable = true;
    jq.enable = true;
    jqp.enable = true;
    wezterm = {
      enable = true;
      enableBashIntegration = true;
    };
    yazi = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
