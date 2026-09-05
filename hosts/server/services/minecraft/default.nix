{ config, pkgs, lib, ... }:

{
  # Ensure tmux is available on the system
  environment.systemPackages = [ pkgs.tmux ];

  # Custom systemd service for Minecraft running inside tmux using Adoptium Java
  systemd.services.minecraft-server = {
    description = "Minecraft Server in Tmux";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];

    serviceConfig = {
      Type = "forking";
      User = "minecraft";
      WorkingDirectory = "/var/lib/minecraft";
      
      # Start a detached tmux session using Adoptium Temurin OpenJDK
      ExecStart = ''
        ${pkgs.tmux}/bin/tmux new-session -d -s minecraft \
        "${pkgs.temurin-bin}/bin/java -Xmx2G -Xms2G -jar /var/lib/minecraft/server.jar nogui"
      '';

      # Send 'stop' to the tmux session gracefully on shutdown
      ExecStop = "${pkgs.tmux}/bin/tmux send-keys -t minecraft stop Enter";
      
      # Give it time to save and shut down
      TimeoutStopSec = 60;
    };
  };

  networking.firewall.allowedTCPPorts = [ 25565 ];
}