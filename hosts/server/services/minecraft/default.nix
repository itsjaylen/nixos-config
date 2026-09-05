{ config, pkgs, lib, ... }:

{
  environment.systemPackages = [ pkgs.tmux ];

  systemd.services.minecraft-server = {
    description = "Minecraft Server in Tmux";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];

    serviceConfig = {
      Type = "forking";
      User = "minecraft";
      Group = "minecraft";
      WorkingDirectory = "/var/lib/minecraft";
      Environment = "HOME=/var/lib/minecraft";

      # Use -d for detached mode so tmux doesn't look for an active terminal
      ExecStart = ''
              ${pkgs.tmux}/bin/tmux new-session -d -s minecraft \
              "${pkgs.temurin-bin}/bin/java -Xmx2G -Xms2G -jar /var/lib/minecraft/versions/26.2/server-26.2.jar nogui"
            '';

      ExecStop = "${pkgs.tmux}/bin/tmux send-keys -t minecraft stop Enter";
      TimeoutStopSec = 60;
    };
  };

  networking.firewall.allowedTCPPorts = [ 25565 ];
}