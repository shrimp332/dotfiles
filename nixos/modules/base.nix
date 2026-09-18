let
  locale = "en_AU.UTF-8";
  tz = "Australia/Melbourne";
in
{ ... }: {
  flake.nixosModules.base = { pkgs, lib, ... }: {

    environment.systemPackages = with pkgs; [
      htop
      git
    ];

    programs.vim = {
      enable = true;
      defaultEditor = true;
    };

    system.autoUpgrade = {
      enable = true;
      flake = "github:shrimp332/dotfiles?dir=nixos#nixbook";
      flags = [ "--refresh" ];
      dates = "weekly";
      randomizedDelaySec = "45min";
      allowReboot = false;
      operation = "boot";
    };

    time.timeZone = tz;
    i18n.defaultLocale = locale;
    i18n.extraLocaleSettings = {
      LC_ADDRESS = locale;
      LC_IDENTIFICATION = locale;
      LC_MEASUREMENT = locale;
      LC_MONETARY = locale;
      LC_NAME = locale;
      LC_NUMERIC = locale;
      LC_PAPER = locale;
      LC_TELEPHONE = locale;
      LC_TIME = locale;
    };

    nixpkgs.config.allowUnfree = true;
    nix.gc.automatic = true;
    nix.gc.options = "--delete-older-than 30d";
    nix.settings.auto-optimise-store = true;
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    programs.mtr.enable = true;
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    networking.firewall.enable = lib.mkDefault true;
  };
}
