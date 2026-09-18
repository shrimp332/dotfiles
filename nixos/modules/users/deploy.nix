{ ... }: {
  flake.nixosModules.deployTarget = { pkgs, ... }: {
    users.users."deploy" = {
      description = "deploy-rs account";
      isSystemUser = true;
      group = "deploy";
      shell = pkgs.bashInteractive;
      home = "/var/lib/deploy-rs-home";
      createHome = true;
      hashedPassword = "!";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKKtYB2jlshgVA4o1MUzU9oqWuOTX2AtOfgGJMuP/8N8 lmcd"
      ];
    };
    users.groups.deploy = { };

    nix.settings.trusted-users = [ "deploy" ];

    security.sudo.extraRules = [
      {
        users = [ "deploy" ];
        commands = [
          {
            command = "ALL";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };
}
