{ pkgs, inputs, config, ... }:

let
  ingestgoPkg = inputs.ingestgo.packages.${pkgs.system}.default;
in {
  sops.secrets."ingestgo/mediamtx_password" = { };
  sops.secrets."ingestgo/obs_password" = { };

  sops.templates."ingestgo-config.toml".content = ''
    [server]
    port = ":7070"

    [database]
    path = "/var/lib/ingestgo/ingestgo.db"

    [mediamtx]
    api_url = "http://127.0.0.1:9997"
    username = "admin"
    password = "${config.sops.placeholder."ingestgo/mediamtx_password"}"

    [obs]
    host = "127.0.0.1:4455"
    password = "${config.sops.placeholder."ingestgo/obs_password"}"
  '';

  systemd.services.ingestgo = {
    description = "ingestgo API engine";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" "mediamtx.service" ];
    wants = [ "network-online.target" ];

    serviceConfig = {
      # Use the credential path, NOT the raw sops template path
      ExecStart = "${ingestgoPkg}/bin/ingestgo --config \${CREDENTIALS_DIRECTORY}/ingestgo-config.toml";
      DynamicUser = true;
      StateDirectory = "ingestgo";
      Restart = "always";
      RestartSec = "5";
      TimeoutStopSec = "20s";

      # This is the line that actually makes it readable
      LoadCredential = "ingestgo-config.toml:${config.sops.templates."ingestgo-config.toml".path}";
    };
  };

  networking.firewall.allowedTCPPorts = [ 7070 ];
}