{ pkgs, inputs, lib, ... }:

let
  youerPackage = pkgs.vanillaServers.vanilla.overrideAttrs (oldAttrs: {
    pname = "youer-server";
    version = "26.3";
    src = ../../../../jars/youer-26.3-956de2c9-server.jar;
  });

  modpack = pkgs.fetchPackwizModpack {
    url = "http://192.168.50.188:3000/itsjaylen/youer-pack/raw/branch/main/pack.toml";
    packHash = "sha256-/sMgVRe9MFSpSZmPSzzqV6kV3x60AFk/ujd4jnxZeHs=";
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

    # Mods: symlinked (read-only is fine, NeoForge doesn't write into mods/)
    symlinks = {
      "mods" = "${modpack}/mods";
    };

    extraStartPre = ''
      # Plugins: copied (writable so they can create their own config dirs like plugins/faststats/)
      mkdir -p plugins
      cp -n --no-preserve=mode,ownership "${modpack}/plugins/"*.jar plugins/ 2>/dev/null || true

      # Configs from packwiz: best-effort copy
      mkdir -p config
      if [ -d "${modpack}/config" ]; then
        cp -r --no-preserve=mode,ownership "${modpack}/config/"* config/ 2>/dev/null || true
      fi
    '';
  };
}