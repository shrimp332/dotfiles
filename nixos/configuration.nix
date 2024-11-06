# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Btrfs options
  fileSystems = {
    "/".options = [ "compress=zstd:6" ];
    "/home".options = [ "compress=zstd:6" ];
  };

  networking.hostName = "nixbook";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Melbourne";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lmcd = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
    ];
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet -r -w 100 -c ${pkgs.sway}/bin/sway";
        user = "lmcd";
      };
      initial_session = {
        command = "${pkgs.sway}/bin/sway";
        user = "lmcd";
      };
    };
  };

  programs.sway.enable = true;
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
  };
  programs.zsh.enable = true;
  programs.dconf.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    zsh-completions
    gettext
    fzf
    starship
    zoxide
    eza
    bat
    vim
    wget
    unzip
    trash-cli
    tlrc

    nerdfetch
    neofetch

    neovim
    git
    gnumake
    lazygit

    gcc
    go
    nodejs_22
    nodePackages.npm
    cargo
    python3

    glib
    gtk2
    gtk3
    gtk4
    grim
    slurp
    wl-clipboard
    mako
    wofi
    waybar
    swayidle
    pamixer
    playerctl
    pavucontrol
    alacritty
    imv
    mpv
    nwg-look
    greetd.tuigreet
    brightnessctl
    autotiling

    firefox-esr
    keepassxc
    vesktop
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    nerdfonts
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # ssh
  services.openssh.enable = true;

  # tlp
  services.tlp.enable = true;

  # Firewall
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  system.stateVersion = "24.05"; # Don't change ever
}

