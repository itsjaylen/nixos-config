{ pkgs, ... }:

{
  services.minecraft-servers.servers.paper = {
    enable = true;
    package = pkgs.paperServers.paper-26_2;
    jvmOpts = "-Xms2G -Xmx2G";

    serverProperties = {
      server-port = 25565;
      motd = "Vanilla Survival";
    };
  };
}