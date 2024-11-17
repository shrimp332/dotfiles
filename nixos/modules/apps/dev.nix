{ pkgs, pkgs-unstable, lib, config, ... }:
{
  options = {
    dev.enable = lib.mkEnableOption "enable dev";
  };

  config = lib.mkIf config.dev.enable {
    environment.systemPackages =
      (with pkgs; [
        git
        lazygit
        gh

        gnumake
        gcc
        nodejs
        go
        cargo
        python3
      ])
      ++
      [
        pkgs-unstable.neovim
      ];
  };
}
