{ pkgs, lib, config, ... }:
{
  options = {
    apps.enable = lib.mkEnableOption "enable desktop apps";
  };

  config = lib.mkIf config.apps.enable {
    environment.systemPackages = with pkgs; [
      alacritty
    ];

    programs.firefox.enable = true;
  };
}
