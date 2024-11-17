{ lib, config, ... }:
{
  options = {
    tailscale.enable = lib.mkEnableOption "enable tailsacle";
  };

  config = lib.mkIf config.tailscale.enable {
    services.tailscale.enable = true;
    networking.firewall.interfaces."tailscale0".allowedTCPPortRanges = [{ from = 0; to = 65535; }];
    networking.firewall.interfaces."tailscale0".allowedUDPPortRanges = [{ from = 0; to = 65535; }];
  };
}
