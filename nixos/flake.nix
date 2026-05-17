{
  description = "System Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, ... }@inputs:
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
      };
    };
}
