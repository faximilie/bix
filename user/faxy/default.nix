{ ... }:
{
  imports = [
    ./desktop
    ./programs
    ./services
    ./sway
  ];

  home = {
    username = "faxy";
    homeDirectory = "/home/faxy";
    preferXdgDirectories = true;
    stateVersion = "26.05";
  };
}
