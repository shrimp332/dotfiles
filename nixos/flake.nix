{
  description = "System Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, ... } @ inputs: 
  let
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      frame = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          ./hosts/frame/configuration.nix 
          ./modules/default.nix

          inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
        ];
      };
    };
  };
}
