{ pkgs, lib, ... }: 
{
  imports = [
    ./apps/common.nix
    ./apps/dev.nix
    ./apps/cli.nix
    ./desktop/sway.nix
    ./services/bluetooth.nix
    ./services/btrfs.nix
    ./services/docker.nix
    ./services/smb.nix
    ./services/tailscale.nix
    ./services/tlp.nix
    ./services/vm.nix
    ./services/windows.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  zramSwap.enable = true;

  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [
    zsh-completions 
  ];

  users.users.lmcd = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "1234";
  };

  time.timeZone = "Australia/Melbourne";

  nixpkgs.config.allowUnfree = true;
  nix.gc.automatic = true;
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh = {
    enable = true;
    openFirewall = false;
  };

  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  fileSystems = {
    "/tmp" = {
      device = "tmpfs";
      fsType = "tmpfs";
    };
  };

  dev.enable = lib.mkDefault true;
  cli.enable = lib.mkDefault true;
}
