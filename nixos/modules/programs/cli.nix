{ self, ... }: {
  flake.nixosModules.cli = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.unstable
    ];

    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;

    environment.systemPackages = with pkgs; [
      eza
      bat
      zoxide
      fzf
      ripgrep
      fd
      trash-cli
      glow
      tealdeer
      dust
      file
      lsof

      curl

      unstable.neovim
      tmux
      lazygit
      btop

      unar
      fastfetch
      starship
      direnv
      steam-run

      gcc
      zig
      cargo
      nodejs
      python3
      gnumake
      just

      man-pages
      man-pages-posix
    ];

    documentation.man.enable = true;
    documentation.dev.enable = true;
    documentation.nixos.enable = true;
  };
}
