{ ... }: {
  flake.nixosModules.lmcd = { pkgs, lib, ... }: {
    users.users."lmcd" = {
      isNormalUser = true;
      description = "lmcd";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      packages = with pkgs; [
      ];
      initialPassword = "1234";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKKtYB2jlshgVA4o1MUzU9oqWuOTX2AtOfgGJMuP/8N8 lmcd"
      ];
    };
  };
}
