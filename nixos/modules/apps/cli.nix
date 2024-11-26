{ pkgs, pkgs-unstable, lib, config, ... }:
{
  options = {
    cli.enable = lib.mkEnableOption "enable cli";
  };

  config = lib.mkIf config.cli.enable {
    environment.systemPackages =
    (with pkgs; [
      gettext
      yazi
      fzf
      ripgrep
      dust
      starship
      zoxide
      eza
      bat
      vim
      wget
      unzip
      trash-cli
      tlrc
      btop
      file
      tmux

      nerdfetch
      neofetch
      git
      gh
    ])
    ++
    [
      pkgs-unstable.neovim
    ];
    

  };
}
