{ pkgs, inputs, lib, ... }:

let
  # Your custom Youer server jar
  youerPackage = pkgs.vanillaServers.vanilla.overrideAttrs (oldAttrs: {
    pname = "youer-server";
    version = "26.3";
    src = ../../../../jars/youer-26.3-956de2c9-server.jar;
  });

  # Mods + plugins from packwiz
  modpack = pkgs.fetchPackwizModpack {
    url = "http://192.168.50.188:3000/itsjaylen/youer-pack/raw/branch/main/pack.toml";
    packHash = lib.fakeHash;
  };
in
{
  services.minecraft-servers.servers.youer = {
    enable = true;
    package = youerPackage;
    jvmOpts = "-Xms4G -Xmx4G";

    serverProperties = {
      server-port = 25566;
      motd = "Modded youer...";
      enforce-secure-profile = false;
      difficulty = "hard";
      render-distance = 25;
    };

    # Mods AND plugins: both symlinked from packwiz
    symlinks = {
      "mods" = "${modpack}/mods";
      "plugins" = "${modpack}/plugins";
    };

    # Configs from packwiz: best-effort copy
    extraStartPre = ''
      mkdir -p config
      if [ -d "${modpack}/config" ]; then
        cp -r --no-preserve=mode,ownership "${modpack}/config/"* config/ 2>/dev/null || true
      fi
    '';
  };
}