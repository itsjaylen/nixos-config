{ pkgs, lib, ... }:

let
  modpack = pkgs.fetchPackwizModpack {
    url = "http://192.168.50.188:3000/itsjaylen/cobbleverse/raw/branch/main/pack.toml";
    packHash = "sha256-A8BXcz7fEVbTBAD2vmY7MzqrHU5vQ0yuCv+z8mJ78aE=";
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

    # Copy mods, configs, and datapacks into the writable server directory
    # (instead of symlinking, which is read-only and breaks LuckPerms)
    files = {
      "mods" = "${modpack}/mods";
      "config" = "${modpack}/config";
      "datapacks" = "${modpack}/datapacks";
    };
  };

  networking.firewall.allowedTCPPorts = [ 25565 ];
  networking.firewall.allowedUDPPorts = [ 24454 ];
}