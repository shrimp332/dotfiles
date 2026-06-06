{ pkgs, lib, config, ... }:
{
  options = {
    apps.enable = lib.mkEnableOption "enable desktop apps";
  };

  config = lib.mkIf config.apps.enable {
    environment.systemPackages = with pkgs; [
      alacritty
      keepassxc
      vesktop
      vscode
      signal-desktop
    ];

    programs.firefox.enable = true;
  };
}
