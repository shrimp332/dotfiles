{ pkgs, pkgs-unstable, lib, config, username, locale, ... }:
{
  imports = [
    ./plasma.nix
  ];

  options = {
    tlp.enable = lib.mkEnableOption "enable tlp";
  };

  config = {
    environment.systemPackages =
      (with pkgs; [
        # navigation
        eza
        zoxide
        fzf

        # git
        git
        lazygit
        gh

        # fetch
        wget
        curl

        # monitor
        btop

        # archive
        unzip
        unrar

        # utils
        tmux
        ripgrep
        bat
        glow
        dust
        trash-cli

        # build tools
        gcc
        go
        cargo

        # misc
        starship
        tealdeer
      ])
      ++ (with pkgs-unstable; [
        neovim
      ]);

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


    programs.nix-ld.enable = true;

    programs.zsh = {
      enable = true;
      enableCompletion = true;
    };

    users.users.${username} = {
      shell = pkgs.zsh;
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      initialPassword = "1234";
    };

    security.sudo.extraConfig = ''
      Defaults pwfeedback
    '';

    time.timeZone = "Australia/Melbourne";

    nixpkgs.config.allowUnfree = true;
    nix.gc.automatic = true;
    nix.settings.auto-optimise-store = true;
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    boot.tmp.useTmpfs = true; # can cause large nix builds to fail

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

    services.tlp = lib.mkIf config.tlp.enable {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      };
    };
  };
}
