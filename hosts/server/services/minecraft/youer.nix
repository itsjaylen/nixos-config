{ pkgs, ... }:

let
  youerPackage = pkgs.vanillaServers.vanilla.overrideAttrs (oldAttrs: {
    pname = "youer-server";
    version = "26.3";
    src = ./jars/youer-26.3-956de2c9-server.jar;
  });
in
{
  services.minecraft-servers.servers.neoforge = {
    enable = true;
    
    package = youerPackage;
    jvmOpts = "-Xms4G -Xmx4G";

    serverProperties = {
      server-port = 25566;
      motd = "Modded youer...";
      enforce-secure-profile = false;
      difficulty = "hard";
    };

    # Imports the master mod router directory
    symlinks = import ./youer-mods { inherit pkgs; };
  };
}