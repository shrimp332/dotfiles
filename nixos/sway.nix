{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./apps.nix
  ];

  options = {
    sway.enable = lib.mkEnableOption "enable sway";
  };

  config = lib.mkIf config.sway.enable {
    environment.systemPackages = with pkgs; [
      tuigreet

      nwg-look

      wofi
      waybar
      nautilus
      adwaita-icon-theme

      grim
      slurp
      wl-clipboard
      autotiling

      dex

      brightnessctl
      playerctl
      pavucontrol

      glib # gsettings
    ];

    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };

    services.greetd = {
      enable = true;
      settings.default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet -r";
      };
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    programs.dconf.enable = true;

    services.gvfs.enable = true;

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-color-emoji
      nerd-fonts.caskaydia-cove
      nerd-fonts.caskaydia-mono
    ];

    qt = {
      enable = true;
      platformTheme = "kde";
      style = "breeze";
    };

    apps.enable = true;
  };
}
