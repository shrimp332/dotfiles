{
  config,
  pkgs,
  lib,
  username,
  ...
}:

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

  fileSystems."/".options = [ "compress=zstd:3" ];
  fileSystems."/home".options = [ "compress=zstd:3" ];

  networking.hostName = "frame";

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  zramSwap.enable = true;

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };
  };

  services.fprintd.enable = true;
  security.pam.services.login.rules.auth.fprintd = {
    control = "sufficient";
    modulePath = "${pkgs.fprintd}/lib/security/pam_fprintd.so";
    order = config.security.pam.services.login.rules.auth.unix.order + 10;
  };
  security.pam.services.greetd.rules.auth.fprintd = {
    control = "sufficient";
    modulePath = "${pkgs.fprintd}/lib/security/pam_fprintd.so";
    order = config.security.pam.services.login.rules.auth.unix.order + 10;
  };
  security.pam.services.sudo.rules.auth.fprintd = {
    control = "sufficient";
    modulePath = "${pkgs.fprintd}/lib/security/pam_fprintd.so";
    order = config.security.pam.services.sudo.rules.auth.unix.order + 10;
  };

  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [
    easyeffects
  ];

  services.fwupd.enable = true;

  sway.enable = true;

  services.syncthing = {
    enable = true;
    user = "${username}";
    group = "users";
    configDir = "/home/${username}/.config";
    dataDir = "/home/${username}";
    overrideDevices = false;
    overrideFolders = false;
  };

  podman.enable = true;

  system.stateVersion = "26.05"; # Don't change after install
}
