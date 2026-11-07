{ config, pkgs, lib, ... }:

let
  syncthingUser = "jaylen";
  syncthingHome = "/home/${syncthingUser}";
in
{
  services.syncthing = {
    enable = true;
    user = syncthingUser;
    group = "users";
    dataDir = syncthingHome;
    configDir = "${syncthingHome}/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;

    settings = {
      devices = {
        "desktop" = { id = "AAAAAAA-BBBBBBB-CCCCCCC-DDDDDDD-EEEEEEE-FFFFFFFF-GGGGGGG-HHHHHHH"; };
        "laptop"  = { id = "IIIIIII-JJJJJJJ-KKKKKKK-LLLLLLL-MMMMMMM-NNNNNNN-OOOOOOO-PPPPPPP"; };
        "server"  = { id = "QQQQQQQ-RRRRRRR-SSSSSSS-TTTTTTT-UUUUUUU-VVVVVVV-WWWWWWW-XXXXXXX"; };
      };

      folders = {
        "Documents" = {
          path = "${syncthingHome}/Documents";
          devices = [ "desktop" "laptop" "server" ];
        };
      };

      gui = {
        user = "admin";
        # SOPS decrypts to a runtime path; Syncthing reads it at start.
        password = "$(cat ${config.sops.secrets."syncthing_gui_password".path})";
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];

  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
}