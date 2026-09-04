{ pkgs, ... }:
{
  networking.hostName = "fred-nerk";

  users.users."faxy" = {
    isNormalUser = true;
    description = "Faxy";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

  system.stateVersion = "26.05";
}
