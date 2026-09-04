{ lib, moduleClass ? null, ... }:
lib.mkMerge [
  (lib.optionalAttrs (moduleClass == "nixos") {
    programs.neovim.defaultEditor = true;
  })
  (lib.optionalAttrs (moduleClass == "home") {
    programs.neovide.enable = true;
    programs.neovim.enable = true;
  })
]
