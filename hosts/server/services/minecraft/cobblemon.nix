{ pkgs, lib, ... }:

let
  # Your Gitea-hosted packwiz pack
  modpack = pkgs.fetchPackwizModpack {
    url = "http://192.168.50.188:3000/itsjaylen/cobbleverse/raw/branch/main/pack.toml";
    packHash = "sha256-1/6SDwFvQloCxUwLErE0sy7Sb0yfbvq4ZMN/QlbOlIY=";
  };
in
{
  services.minecraft-servers.servers.cobblemon = {
    enable = true;

    # Fabric server — Nix fetches the launcher and vanilla jar
    # Note: version uses underscores, not dots
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

    # Mods, configs, and datapacks come from the packwiz modpack
    symlinks.mods = "${modpack}/mods";
    files = {
      "config" = "${modpack}/config";
      "datapacks" = "${modpack}/datapacks";
    };
  };

  # Open the port for this server
  networking.firewall.allowedTCPPorts = [ 25565 ];

  # Simple Voice Chat needs its own UDP port
  networking.firewall.allowedUDPPorts = [ 24454 ];
}