{ config, pkgs, ... }: {
  services.redis.servers.main = {
    enable = true;
    bind = "127.0.0.1";
    port = 6379;
  };
}