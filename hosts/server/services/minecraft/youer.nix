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

    serverProperties = { /* unchanged */ };

    symlinks = {
      "mods" = "${modpack}/mods";
      "plugins" = "${modpack}/plugins";
    };

    extraStartPre = ''
      mkdir -p config
      if [ -d "${modpack}/config" ]; then
        cp -r --no-preserve=mode,ownership "${modpack}/config/"* config/
      fi
    '';
  };
}