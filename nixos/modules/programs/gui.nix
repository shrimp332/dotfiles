{ ... }: {
  flake.nixosModules.gui = { pkgs, lib, ... }: {
    environment.systemPackages = (
      with pkgs;
      [
        alacritty
        vesktop
        keepassxc

        imv
        mpv

        brightnessctl
        pavucontrol
      ]
    );

    programs.firefox = {
      enable = true;
      package = pkgs.librewolf;
    };
  };
}
