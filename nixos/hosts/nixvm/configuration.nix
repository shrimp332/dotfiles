{ lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # fileSystems."/".options = [ "compress=zstd:6" ];

  # boot.kernelParams = [ "console=ttyS0" ];
  # boot.loader.grub.extraConfig = ''
  #   serial --speed=115200
  #   terminal_input serial
  #   terminal_output serial
  # '';

  networking.hostName = "nixvm";
  networking.firewall.enable = lib.mkForce false;

  zramSwap.enable = true;

  plasma.enable = true;

  system.stateVersion = "25.11"; # Don't change after install
}
