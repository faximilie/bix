{ ... }:
{
  users.users.faxy = {
    isNormalUser = true;
    description = "Faxy";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
