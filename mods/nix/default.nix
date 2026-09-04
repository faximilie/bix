{ ... }:
{
  nix = {
    enable = true;
    settings = {
      substituters = [
        "https://cache.nixos.org"
        "https://doom-emacs-unstraightened.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "doom-emacs-unstraightened.cachix.org-1:O5oOlRPnmQEvVaFyuMTmthCEooHbrg54WgSLR07tmg4="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      experimental-features = [ "nix-command" "flakes" ];
      use-xdg-base-directories = true;
    };
  };
}
