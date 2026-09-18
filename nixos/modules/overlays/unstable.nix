{ inputs, ... }: {
  flake.nixosModules.unstable = { pkgs, lib, ... }: {
    nixpkgs.overlays = [
      (final: prev: {
        unstable = import inputs.nixpkgs-unstable {
          inherit (prev.stdenv.hostPlatform) system;
          config.allowUnfree = true;
        };
      })
    ];
  };
}
