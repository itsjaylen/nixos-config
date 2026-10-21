{ pkgs, inputs, ... }:

let
  ingestgoPkg = inputs.ingestgo.packages.${pkgs.system}.default;
in {
  environment.etc."ingestgo/config.toml".text = ''
    [server]
    port = ":7070"

    [database]
    path = "/var/lib/ingestgo/ingestgo.db"

    [mediamtx]
    api_url = "http://127.0.0.1:9997"
    username = "admin"
    password = "changeme"

    [obs]
    host = "127.0.0.1:4455"
    password = "changeme"
  '';

  systemd.services.ingestgo = {
    description = "ingestgo API engine";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" "mediamtx.service" ];
    wants = [ "network-online.target" ];

    serviceConfig = {
      ExecStart = "${ingestgoPkg}/bin/ingestgo --config /etc/ingestgo/config.toml";
      DynamicUser = true;
      StateDirectory = "ingestgo";
      Restart = "always";
      RestartSec = "5";
      TimeoutStopSec = "20s";
    };
  };

  networking.firewall.allowedTCPPorts = [ 7070 ];
}