{ pkgs, ... }:

let
  youerPackage = pkgs.vanillaServers.vanilla.overrideAttrs (oldAttrs: {
    pname = "youer-server";
    version = "26.2";
    src = pkgs.fetchurl {
      url = "https://api.mohistmc.com/project/youer/26.2/builds/latest/download";
      sha256 = "e3b834809eb8740611c6cbebe163e533d1bb045145f4ceff94cc19d6a2682ac0";
    };
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
    symlinks = import ./modded-mods { inherit pkgs; };
  };
}