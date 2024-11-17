# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  
  networking.hostName = "frame";
  services.hardware.bolt.enable = true;
  services.fwupd.enable = true;

  common.enable = true;

  sway.enable = true;

  bluetooth.enable = true;
  btrfs.enable = true;
  docker.enable = true;
  smb.enable = true;
  tailscale.enable = true;
  tlp.enable = true;
  vm.enable = true;
  windows.enable = true;

  system.stateVersion = "24.05"; # Don't change after install
}
