{ pkgs, lib, ... }:

let
  serverFiles = pkgs.fetchgit {
    url = "http://192.168.50.188:3000/itsjaylen/cobbleverse-server.git";
    rev = "7732fbf9b4af1bfd0e7e303ae888b22a5b2735ad";
    sha256 = "06x78148cgpjiaxfp3zn13xmkp94yx7iwmdxaqci6wag99rxdqd9";
  };
in
{
  services.minecraft-servers.servers.cobblemon = {
    enable = true;

    package = pkgs.fabricServers.fabric-1_21_1.override {
      loaderVersion = "0.19.5";
    };

    jvmOpts = "-Xms6G -Xmx6G";

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