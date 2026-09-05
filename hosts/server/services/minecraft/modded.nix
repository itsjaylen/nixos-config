{ pkgs, ... }:

{
  services.minecraft-servers.servers.modded = {
    enable = true; # Set to false to disable this server instantly without deleting code
    package = pkgs.paperServers.paper-26_2;
    jvmOpts = "-Xms4G -Xmx4G";

    serverProperties = {
      server-port = 25566;
      motd = "Modded Chaos";
    };
  };
}