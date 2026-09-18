{ ... }: {
  flake.nixosModules.tailscale = { pkgs, lib, ... }: {
    services.tailscale = {
      enable = true;
      openFirewall = true;
    };

    services.openssh = {
      enable = true;
      openFirewall = false;
    };

    networking.firewall.trustedInterfaces = [ "tailscale0" ];
    fileSystems."/mnt/rocky/shared" = {
      device = "100.118.116.144:/mnt/shared";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "noauto"
        "x-systemd.idle-timeout=300"
      ];
    };
    fileSystems."/mnt/rocky/home" = {
      device = "100.118.116.144:/mnt/home";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "noauto"
        "x-systemd.idle-timeout=300"
      ];
    };
    fileSystems."/mnt/rocky/lmcd" = {
      device = "100.118.116.144:/mnt/lmcd";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "noauto"
        "x-systemd.idle-timeout=300"
      ];
    };
  };
}
