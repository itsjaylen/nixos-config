{ pkgs, ... }:

let
  youerPackage = pkgs.vanillaServers.vanilla.overrideAttrs (oldAttrs: {
    pname = "youer-server";
    version = "26.2";
    src = pkgs.fetchurl {
      url = "https://api.mohistmc.com/project/youer/26.2/builds/latest/download";
      sha256 = "47116296239b3f114c82166fd3a45ca26c8875e277906dd8289099628af09926";
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
      motd = "Modded youer";
      enforce-secure-profile = false;
      difficulty = "hard";
    };

    # Imports the master mod router directory
    symlinks = import ./mods { inherit pkgs; };
  };
}