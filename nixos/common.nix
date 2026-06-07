{
  pkgs,
  pkgs-unstable,
  lib,
  config,
  username,
  locale,
  ...
}:
{
  imports = [
    ./plasma.nix
    ./sway.nix
    ./podman.nix
  ];

  options = { };

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
        direnv

        # build tools
        gcc
        go
        cargo
        nodejs

        # misc
        starship
        tealdeer
        fastfetch
        claude-code
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

    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [

      ];
    };

    programs.zsh = {
      enable = true;
      enableCompletion = true;
    };

    users.users.${username} = {
      shell = pkgs.zsh;
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
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

    networking.networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-openconnect
      ];
    };
    networking.firewall.enable = true;

    services.tailscale = {
      enable = true;
      extraUpFlags = [ "--accept-dns=false" ];
    };
    networking.firewall.trustedInterfaces = [ "tailscale0" ];
  };
}
