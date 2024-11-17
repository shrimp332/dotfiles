{
  description = "System Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
  };

  outputs = { self, ... } @ inputs: 
  let
    system = "x86_64-linux";
    lib = inputs.nixpkgs.lib;
    pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
  in {
    nixosConfigurations = {
      frame = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./hosts/frame/configuration.nix 
          ./modules/default.nix

          inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
        ];
        specialArgs = {
          inherit pkgs-unstable;
        };
      };

      nixvm = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./hosts/nixvm/configuration.nix 
          ./modules/default.nix
        ];
        specialArgs = {
          inherit pkgs-unstable;
        };
      };
    };
  };
}
