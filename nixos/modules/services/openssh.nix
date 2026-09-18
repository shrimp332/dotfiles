{ ... }: {
  flake.nixosModules.openssh = { pkgs, lib, ... }: {
    services.openssh = {
      enable = true;
      openFirewall = lib.mkDefault true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };
  };
}
