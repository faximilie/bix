{ pkgs, ... }:
{
  users.users.faxy = {
    isNormalUser = true;
    description = "Faxy";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };
}
