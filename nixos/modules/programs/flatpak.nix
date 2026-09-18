{ inputs, ... }: {
  flake.nixosModules.flatpak = { pkgs, lib, ... }: {
    imports = [
      inputs.nix-flatpak.nixosModules.nix-flatpak
    ];

    services.flatpak = {
      enable = true;
      packages = [
        "com.github.tchx84.Flatseal"
        "com.obsproject.Studio"
        "md.obsidian.Obsidian"
        "org.onlyoffice.desktopeditors"
        "org.chromium.Chromium"
      ];
    };
  };
}
