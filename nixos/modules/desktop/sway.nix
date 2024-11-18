{ pkgs, lib, config, username, ... }:
{
  options = {
    sway.enable = lib.mkEnableOption "enable sway";
  };

  config = lib.mkIf config.sway.enable {
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    environment.systemPackages = with pkgs; [
      pamixer
      playerctl
      pulseaudio
      pavucontrol

      xfce.tumbler
      ffmpegthumbnailer
      webp-pixbuf-loader
      ark

      nwg-look
      grim
      slurp
      wl-clipboard
      mako
      libnotify
      wofi
      waybar
      swayidle
      brightnessctl
      autotiling

      greetd.tuigreet

      imv
      mpv
      alacritty
    ];
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      # nerdfonts
      (nerdfonts.override { fonts = [ "CascadiaCode" "CascadiaMono" ];})
    ];

    # Login manager
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet -r -w 100 -c ${pkgs.sway}/bin/sway";
          user = username;
        };
        initial_session = {
          command = "${pkgs.sway}/bin/sway";
          user = username;
        };
      };
    };

    # Audio
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };


    programs.sway.enable = true;

    
    # File Manager
    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
    };
    services.gvfs.enable = true;
  };
}
