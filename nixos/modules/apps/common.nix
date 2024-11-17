{ pkgs, lib, config, ... }: {

  options = {
    common.enable = lib.mkEnableOption "enable common";
  };

  config = lib.mkIf config.common.enable {
    environment.systemPackages = with pkgs; [
      firefox-esr
      keepassxc
      vesktop
      signal-desktop
      obsidian
      vscode
      mission-center
    ];
  };
}
