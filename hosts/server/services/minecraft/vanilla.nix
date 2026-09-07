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

    symlinks = {
      "plugins/tcpshield.jar" = pkgs.fetchurl {
        url = "https://github.com/TCPShield/RealIP/releases/download/2.8.1/TCPShield-2.8.1.jar";
        sha512 = "sha512-wB4COs8nDOBXyZJap5c8X4L2GcnXmcln+bIs/jTt4XJAY/ETU7FwzpsOfFbXnVEXM6SBf/NiJMRnKJ9MgTUzKw==";
      };
    };
  };
}