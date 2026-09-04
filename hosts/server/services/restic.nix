{ config, pkgs, ... }: {
  # Build environment file with S3 credentials for Restic systemd service
  sops.templates."restic-env" = {
    content = ''
      AWS_ACCESS_KEY_ID=${config.sops.placeholder.garage_s3_access_key}
      AWS_SECRET_ACCESS_KEY=${config.sops.placeholder.garage_s3_secret_key}
      RESTIC_PASSWORD=${config.sops.placeholder.restic_password}
    '';
    owner = "root";
  };

  # Install restic package system-wide for manual CLI runs
  environment.systemPackages = [ pkgs.restic ];

  services.restic.backups = {
    garage-local = {
      # Initialize repo automatically if it doesn't exist
      initialize = true;

      # Point to your local Garage S3 bucket
      repository = "s3:http://127.0.0.1:3900/my-bucket";

      # Feed decrypted S3 credentials and repository password
      environmentFile = config.sops.templates."restic-env".path;

      # What paths/services to back up
      paths = [
        "/var/lib/gitea"
        "/var/lib/minecraft"
        "/etc/nixos"
      ];

      # Backup schedule (Daily at 2:00 AM)
      timerConfig = {
        OnCalendar = "02:00";
        Persistent = true;
      };

      # Prune policy to manage storage retention
      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 4"
        "--keep-monthly 12"
      ];
    };
  };
}