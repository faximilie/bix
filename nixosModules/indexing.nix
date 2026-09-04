{ pkgs, ... }:
{
  services.locate = {
    enable = true;
    package = pkgs.plocate;
    interval = "hourly";
    pruneNames = [
      "*.pyc"
      "*.pyo"
      ".DS_Store"
      ".Trash-"
      ".bzr"
      ".cache"
      ".cargo"
      ".class"
      ".git"
      ".hg"
      ".local"
      ".svn"
      ".thumbnail"
      "argo"
      "node_modules"
      "ower_components"
    ];
  };
}
