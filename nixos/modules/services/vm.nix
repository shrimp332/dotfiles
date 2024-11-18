{ lib, config, username, ... }: {
  
  options = {
    vm.enable = lib.mkEnableOption "enable vm";
  };

  config = lib.mkIf config.vm.enable {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;

    users.users.${username}.extraGroups = [ "libvirtd" ];
  };
}
