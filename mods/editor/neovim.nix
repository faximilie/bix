{ lib, options, ... }:
lib.mkMerge [
  (lib.optionalAttrs (options ? programs.neovim.defaultEditor) {
    programs.neovim.defaultEditor = true;
  })
  (lib.optionalAttrs (options ? home) {
    programs.neovide.enable = true;
    programs.neovim.enable = true;
  })
]
