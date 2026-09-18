{ self, ... }: {
  flake.nixosModules.plasma = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.fonts
      self.nixosModules.gui
      self.nixosModules.audio
    ];

    services = {
      desktopManager.plasma6.enable = true;
      displayManager.plasma-login-manager.enable = true;
    };

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      elisa
      konsole
      gwenview
      kate
      khelpcenter
      ktexteditor
      plasma-keyboard
      discover
      qrca
    ];

    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
