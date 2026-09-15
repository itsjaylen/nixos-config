secrets = {
  "github_ssh_key" = {
    owner = "jaylen";
    group = "users";
    path = "/home/jaylen/.ssh/id_ed25519";
    mode = "0600";
  };
  "gitea_token" = {
    owner = "jaylen";
    group = "users";
  };
  "garage_rpc_secret" = { };
  "garage_s3_access_key" = { };
  "garage_s3_secret_key" = { };
  "restic_password" = { };
  "grafana_admin_password" = { };
  "grafana_secret_key" = { };
  "gitea_runner_token" = { };
  "s3_secret_key" = { };
} // lib.optionalAttrs (builtins.hasAttr "rustlog" config.users.users) {
  "rustlog/config" = {
    owner = "rustlog";
    group = "rustlog";
    path = "/var/lib/rustlog/config.json";
    mode = "0400";
  };
};