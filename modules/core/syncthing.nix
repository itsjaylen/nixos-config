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
        "desktop" = { id = "ZRLUC6M-ZKDGMI4-FN5DBYQ-WZ4ET6U-OAEPM2X-4M4UNBL-L22WRL2-3RHWWQP"; };
        "laptop"  = { id = "VA5JXMM-OCPVORD-HMQZ3GI-CKCBTUB-WPPPUCQ-ERTX46J-ZNKX5AN-2TFQOAM"; };
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
        password = "$2y$10$iPNwZXoPPYF9Jn2T1HQfGuk1UZWqrMq9SRaLdBb99myH23Srbl162";
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];

  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
}