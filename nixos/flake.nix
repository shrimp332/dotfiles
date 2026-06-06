{
  description = "System Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixos-hardware, ... }@inputs:
    let
      system = "x86_64-linux";
      username = "lmcd";
      locale = "en_AU.UTF-8";
      lib = inputs.nixpkgs.lib;
      pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        nixvm = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/nixvm/configuration.nix
            ./common.nix
          ];
          specialArgs = {
            inherit locale;
            inherit username;
            inherit pkgs-unstable;
          };
        };
        nixbook = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/nixbook/configuration.nix
            ./common.nix
          ];
          specialArgs = {
            inherit locale;
            inherit username;
            inherit pkgs-unstable;
          };
        };
        frame = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/frame/configuration.nix
            ./common.nix
            nixos-hardware.nixosModules.framework-12th-gen-intel
          ];
          specialArgs = {
            inherit locale;
            inherit username;
            inherit pkgs-unstable;
          };
        };
      };
    };
}
