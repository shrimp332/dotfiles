{ ... }: {
  flake.nixosModules.games = { pkgs, lib, ... }: {
    programs.java.enable = true;

    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      extraPackages = [ pkgs.jdk ];
    };

    environment.systemPackages = with pkgs; [
      heroic
    ];
  };
}
