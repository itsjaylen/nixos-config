{ config, pkgs, ... }:

let
  s3AccessKey = config.sops.secrets."garage_s3_access_key".path;
  s3SecretKey = config.sops.secrets."garage_s3_secret_key".path;
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
    package = pkgs.garage;

    settings = {
      replication_factor = 1;
      rpc_bind_addr = "[::]:3901";

      s3_api = {
        s3_region = "garageland";
        api_bind_addr = "127.0.0.1:3900";
        root_domain = ".s3.garage.localhost";
      };

      storage = {
        engine = "sqlite";
        data_dir = "/var/lib/garage/data";
        metadata_dir = "/var/lib/garage/meta";
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
    };
    script = ''
      RPC_SECRET=$(cat /run/secrets/garage_rpc_secret)
      ACCESS_KEY=$(cat ${s3AccessKey})
      SECRET_KEY=$(cat ${s3SecretKey})

      # Wait for garage daemon API to respond
      until ${pkgs.garage}/bin/garage --rpc-secret "$RPC_SECRET" status >/dev/null 2>&1; do
        sleep 1
      done

      # Import/Import key from SOPS secrets
      ${pkgs.garage}/bin/garage --rpc-secret "$RPC_SECRET" key import main-key "$ACCESS_KEY" "$SECRET_KEY" || true

      # Ensure bucket exists and grant access
      ${pkgs.garage}/bin/garage --rpc-secret "$RPC_SECRET" bucket create my-bucket || true
      ${pkgs.garage}/bin/garage --rpc-secret "$RPC_SECRET" bucket allow my-bucket --key main-key --read --write || true
    '';
  };

  systemd.services.garage.serviceConfig = {
    EnvironmentFile = config.sops.templates."garage-env".path;
  };

  networking.firewall.allowedTCPPorts = [ 3900 ];
}