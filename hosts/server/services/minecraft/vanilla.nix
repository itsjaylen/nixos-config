{ pkgs, ... }:

{
  services.minecraft-servers.servers.paper = {
    enable = true;
    package = pkgs.paperServers.paper-26_2e.override {
      jre_headless = pkgs.temurin-bin-21;
    };
    jvmOpts = "-Xms2G -Xmx2G";

    serverProperties = {
      server-port = 25565;
      motd = "Vanilla Survival";
    };
  };
}