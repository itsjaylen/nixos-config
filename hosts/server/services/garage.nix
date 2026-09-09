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
      description = "Declarative Garage Cluster Layout, Bucket and Key Provisioning";
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
  
        # 1. Automatically fetch the local node ID
        NODE_ID=$(${pkgs.garage}/bin/garage --rpc-secret "$RPC_SECRET" status | awk 'NR==3 {print $1}')
  
        if [ -n "$NODE_ID" ]; then
          # 2. Automatically assign node if it has no role assigned yet
          if ${pkgs.garage}/bin/garage --rpc-secret "$RPC_SECRET" status | grep -q "NO ROLE ASSIGNED"; then
            echo "Assigning node $NODE_ID to zone1..."
            ${pkgs.garage}/bin/garage --rpc-secret "$RPC_SECRET" layout assign --zone zone1 --capacity 10G "$NODE_ID"
            
            # Fetch current layout version or default to 1, then apply incremented version
            CURRENT_VERSION=$(${pkgs.garage}/bin/garage --rpc-secret "$RPC_SECRET" layout show | grep "Layout version:" | awk '{print $3}')
            NEXT_VERSION=$(( { CURRENT_VERSION:-0} + 1 ))
            
            echo "Applying layout version $NEXT_VERSION..."
            ${pkgs.garage}/bin/garage --rpc-secret "$RPC_SECRET" layout apply --version "$NEXT_VERSION"
          fi
        fi
  
        # 3. Import key and create bucket
        ${pkgs.garage}/bin/garage --rpc-secret "$RPC_SECRET" key import main-key "$ACCESS_KEY" "$SECRET_KEY" || true
        ${pkgs.garage}/bin/garage --rpc-secret "$RPC_SECRET" bucket create slopuploader-files || true
        ${pkgs.garage}/bin/garage --rpc-secret "$RPC_SECRET" bucket allow slopuploader-files --key main-key --read --write || true
      '';
    };

  systemd.services.garage.serviceConfig = {
    EnvironmentFile = config.sops.templates."garage-env".path;
  };

  networking.firewall.allowedTCPPorts = [ 3900 ];
}