{ self, ... }: {
  flake.nixosModules.workstation = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.cli
      self.nixosModules.plasma
      self.nixosModules.flatpak
      self.nixosModules.tailscale
    ];
  };
}
