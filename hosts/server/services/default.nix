{ ... }: {
  imports = [
    ./cloudflared.nix
    ./garage.nix
    ./gitea.nix
    ./postgresql.nix
    ./restic.nix
    ./glance.nix
    ./prometheus.nix
    ./grafana.nix
    ./loki.nix
    ./adguard.nix
    ./minecraft
  ];
}