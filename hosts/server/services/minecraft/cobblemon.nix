{ pkgs, lib, ... }:

let
  serverFiles = pkgs.fetchgit {
    url = "http://192.168.50.188:3000/itsjaylen/cobbleverse-server.git";
    rev = "ba28aaa8896112f16c936f4dfc80d344dcea480b";
    sha256 = "0fjjgk3vk0jwbm4m1jr6g28hnq0wz2qmca4i069hgik7xb3bbhsx";
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