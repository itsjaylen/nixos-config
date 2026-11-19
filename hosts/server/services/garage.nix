{ config, pkgs, ... }:

let
  s3AccessKey = config.sops.secrets."garage_s3_access_key".path;
  s3SecretKey = config.sops.secrets."garage_s3_secret_key".path;
  garageBin = "${config.services.garage.package}/bin/garage";
in
{
  # Build a single environment file containing the decrypted RPC secret for systemd
  sops.templates."garage-env" = {
    content = ''
      GARAGE_RPC_SECRET=${config.sops.placeholder.garage_rpc_secret}
    '';
    owner = "root";
  };

  services.garage = {
    enable = true;
    package = pkgs.garage_2;

    settings = {
      replication_factor = 1;
      rpc_bind_addr = "[::]:3901";

      # Match whichever DB file exists in /var/lib/garage/meta ("lmdb" or "sqlite")
      db_engine = "lmdb";
      data_dir = "/var/lib/garage/data";
      metadata_dir = "/var/lib/garage/meta";

      s3_api = {
        s3_region = "garageland";
        api_bind_addr = "0.0.0.0:3900";
        root_domain = ".s3.garage.localhost";
      };
    };
  };

  # Automatically import key credentials and create bucket on service startup
  systemd.services.garage-init = {
    description = "Declarative Garage Bucket and Key Provisioning";
    after = [ "garage.service" ];
    wants = [ "garage.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      EnvironmentFile = config.sops.templates."garage-env".path;
    };
    script = ''
      ACCESS_KEY=$(cat ${s3AccessKey})
      SECRET_KEY=$(cat ${s3SecretKey})

      # Wait for garage daemon RPC to respond
      until ${garageBin} status >/dev/null 2>&1; do
        sleep 1
      done

      # Import key from SOPS secrets
      ${garageBin} key import --yes -n main-key "$ACCESS_KEY" "$SECRET_KEY" || true

      # Ensure bucket exists and grant access (matching .envrc S3_BUCKET)
      ${garageBin} bucket create slopuploader-files || true
      ${garageBin} bucket allow slopuploader-files --key main-key --read --write || true
    '';
  };

  systemd.services.garage.serviceConfig = {
    EnvironmentFile = config.sops.templates."garage-env".path;
  };

  networking.firewall.allowedTCPPorts = [ 3900 ];
}