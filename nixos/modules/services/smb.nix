{ pkgs, lib, config, username, ...}:
{
  options = {
    smb.enable = lib.mkEnableOption "enable smb";
  };
  

  config = lib.mkIf config.smb.enable {
    environment.systemPackages = with pkgs; [
      cifs-utils
    ];
    fileSystems = { "/mnt/lmcd" = {
        device = "//100.118.116.144/lmcd";
        fsType = "cifs";
        options = let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
        in ["${automount_opts},uid=${username},file_mode=0660,dir_mode=0770,credentials=/root/smb.secret"];
      };
      "/mnt/shared" = {
        device = "//100.118.116.144/shared";
        fsType = "cifs";
        options = let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
        in ["${automount_opts},uid=${username},file_mode=0660,dir_mode=0770,credentials=/root/smb.secret"];
      };
    };
  };
}
