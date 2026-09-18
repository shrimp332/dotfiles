{ self, ... }: {
  flake.nixosModules.tailscale = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.openssh
    ];

    services.tailscale = {
      enable = true;
      openFirewall = true;
    };

    # ssh doesn't need firewall with tailscale
    services.openssh.openFirewall = false;
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
