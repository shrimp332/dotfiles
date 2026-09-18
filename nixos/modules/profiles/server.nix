{ self, ... }: {
  flake.nixosModules.server = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.openssh
      self.nixosModules.tailscale
    ];
  };
}
