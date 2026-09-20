{ pkgs, lib, ... }:

let
  modpack = pkgs.fetchPackwizModpack {
    url = "http://192.168.50.188:3000/itsjaylen/cobbleverse/raw/branch/main/pack.toml";
    packHash = "+2VDy+a3Ns1OKxfpg=";
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

    # Copy mods into the writable server directory.
    # Config and datapacks are managed manually on the server for now,
    # since packwiz doesn't currently include them in the built derivation.
    files = {
      "mods" = "${modpack}/mods";
    };
  };

  networking.firewall.allowedTCPPorts = [ 25565 ];
  networking.firewall.allowedUDPPorts = [ 24454 ];
}