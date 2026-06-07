{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    podman.enable = lib.mkEnableOption "enable podman";
  };

  config = lib.mkIf config.podman.enable {
    virtualisation.containers.enable = true;
    virtualisation = {
      podman = {
        enable = true;
        dockerCompat = true;
        dockerSocket.enable = true;
        defaultNetwork.settings.dns_enabled = true;
      };
    };

    environment.systemPackages = with pkgs; [
      podman-compose
    ];
  };
}
