{ self, inputs, ... }: {
  flake.nixosConfigurations.nixbook = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.nixbookConfiguration
      self.nixosModules.base
      self.nixosModules.workstation
    ];
  };

  flake.nixosModules.nixbookConfiguration = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.nixbookHardware
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    boot.tmp.useTmpfs = true; # Can cause large rebuilds to fail

    zramSwap.enable = true;

    networking.hostName = "nixbook";
    networking.networkmanager.enable = true;

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
