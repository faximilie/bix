{ ... }:
{
  systemd.services.tailscaled.serviceConfig.Environment = [ "TS_DEBUG_FIREWALL_MODE=nftables" ];
  services.tailscale.enable = true;
}
