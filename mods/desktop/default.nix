{ pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ vulkan-loader vulkan-validation-layers vulkan-extension-layer mesa ];
    extraPackages32 = with pkgs; [ driversi686Linux.mesa ];
  };
  services.xserver = {
    videoDrivers = [ "nvidia" ];
    xkb = {
      layout = "au";
      variant = "";
    };
  };
}
