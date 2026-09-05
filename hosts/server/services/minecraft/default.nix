{ config, pkgs, lib, ... }:

{
  servers.minecraft = {
        enable = true;
        
        # Use Paper and override its JRE package to Eclipse Temurin (pkgs.temurin-bin)
        package = (pkgs.paperServers.paper-26_2.override {
          jre = pkgs.temurin-bin;
        });
  
        jvmOpts = "-Xms2G -Xmx2G";
  
        serverProperties = {
          server-port = 25565;
          motd = "Jaylen's Minecraft Server";
          online-mode = true;
          enable-command-block = true;
          view-distance = 10;
          simulation-distance = 10;
        };
      };

  networking.firewall.allowedTCPPorts = [
    25565
  ];
}
