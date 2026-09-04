{ ... }:
{
  programs.uwsm = {
    enable = true;
    waylandCompositors.sway = {
      prettyName = "Sway Nvidia";
      comment = "Sway compositor with --unsuported-gpu managed by UWSM";
      binPath = "/run/current-system/sw/bin/sway";
      extraArgs = [ "--unsupported-gpu" ];
    };
  };
}
