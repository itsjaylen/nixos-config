{ pkgs, ... }:

{
  services.minecraft-servers.servers.neoforge = {
    enable = true;
    package = pkgs.neoforgeServers.neoforge-26_2;
    jvmOpts = "-Xms2G -Xmx2G";

    serverProperties = {
      server-port = 25566;
      motd = "Modded";
    };

    symlinks = {
      "mods/jade.jar" = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/nvQzSEkH/versions/GBES6etT/Jade-mc26.2-NeoForge-26.2.10.jar";
        sha512 = "23c4ce0e0aec0d70b38ba5c8a346e5233aaa3923a94f54dc1b412e48ef98d394d3a1ac3ceaa9fe674dc1653bbef489a228be167f011d163db7ae6e4a947051b9";
      };
    };
  };
}