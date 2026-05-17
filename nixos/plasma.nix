{ pkgs, lib, config, ... }:
{
  imports = [
    ./apps.nix
  ];

  options = {
    plasma.enable = lib.mkEnableOption "enable plasma desktop";
  };

  config = lib.mkIf config.plasma.enable {
    services = {
      desktopManager.plasma6.enable = true;
      displayManager.sddm.enable = true;
      displayManager.sddm.wayland.enable = true;
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-color-emoji
      nerd-fonts.caskaydia-cove
      nerd-fonts.caskaydia-mono
    ];

    apps.enable = true;
  };
}
