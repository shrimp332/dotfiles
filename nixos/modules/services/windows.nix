{ pkgs, lib, config, ... }: {
  options = {
    windows.enable = lib.mkEnableOption "enable windows";
  };

  config = lib.mkIf config.windows.enable {

    environment.systemPackages = with pkgs; [
      bottles
      wineWowPackages.stable
    ];
  };
}
