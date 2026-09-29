{ config, pkgs, ... }:

{
  # Ensure Podman is available
  virtualisation.podman.enable = true;
  # This creates a 'docker' alias for convenience
  virtualisation.podman.dockerCompat = true;

  # Install podman-compose and other tools
  environment.systemPackages = with pkgs; [
    podman-compose
    openssl # To generate the required secrets
  ];

  # Define the Planly service
  systemd.services.planly = {
    description = "Planly Project Management";
    after = [ "network.target" ];
    wants = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = "yes";
      # Change this to the actual path where you cloned Planly
      WorkingDirectory = "/var/lib/planly";
      # The command to start Planly in the background
      ExecStart = "${pkgs.podman-compose}/bin/podman-compose up -d";
      # The command to stop it
      ExecStop = "${pkgs.podman-compose}/bin/podman-compose down";
      # Run as root for simplicity, or create a dedicated user for better security
      User = "root";
    };
  };
}