# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  
  networking.hostName = "red";
  networking.firewall.enable = lib.mkForce false;

  btrfs.enable = true;

  system.stateVersion = "24.05"; # Don't change after install
}
