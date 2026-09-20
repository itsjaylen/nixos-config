{ pkgs, lib, ... }:

let
  serverFiles = pkgs.fetchgit {
    url = "http://192.168.50.188:3000/itsjaylen/cobbleverse-server.git";
    rev = "7eb66483a9a20c12e83b8a9d03d0ea511ed3eb7b";
    sha256 = "0bkcbxc4hb1yir33mmbasjkbi18nb6rb7vm01qiwc6qw6i5h06v6";
  };
in
{
  services.minecraft-servers.servers.cobblemon = {
    enable = true;

    package = pkgs.fabricServers.fabric-1_21_1.override {
      loaderVersion = "0.19.5";
    };

    jvmOpts = "-Xms6G -Xmx12G";

    serverProperties = {
      server-port = 25565;
      motd = "Cobbleverse Server";
      enforce-secure-profile = false;
      difficulty = "normal";
    };

    files = {
      "mods" = "${serverFiles}/mods";
      "config" = "${serverFiles}/config";
      "datapacks" = "${serverFiles}/datapacks";
    };
  };

  networking.firewall.allowedTCPPorts = [ 25565 ];
  networking.firewall.allowedUDPPorts = [ 24454 ];
}