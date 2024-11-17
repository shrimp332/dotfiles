{ lib, config, ...}:
{
  options = {
    btrfs.enable = lib.mkEnableOption "enable btrfs";
  };

  config = lib.mkIf config.btrfs.enable {
    fileSystems = {
      "/".options = [ "compress=zstd:6" ];
      "/home".options = [ "compress=zstd:6" ];
    };
    services.btrfs.autoScrub.enable = true;


    virtualisation.docker = { 
      storageDriver = "btrfs";
    };
  };
}
