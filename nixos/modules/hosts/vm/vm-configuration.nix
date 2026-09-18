{ self, inputs, ... }: {
  flake.nixosConfigurations.vm = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.vmConfiguration
      self.nixosModules.base
      self.nixosModules.workstation
      self.nixosModules.games
    ];
  };

  flake.nixosModules.vmConfiguration = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.vmHardware
    ];

    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/vda";
    boot.loader.grub.useOSProber = true;
    boot.loader.grub.fsIdentifier = "provided";
    boot.tmp.useTmpfs = true; # Can cause large rebuilds to fail

    networking.hostName = "vm";
    networking.networkmanager.enable = true;

    services.qemuGuest.enable = true;
    services.spice-vdagentd.enable = true;

    services.printing.enable = true;

    users.users."lmcd" = {
      isNormalUser = true;
      description = "lmcd";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      packages = with pkgs; [
      ];
      initialPassword = "1234";
    };

    # Never change this value
    system.stateVersion = "26.05";
  };
}
