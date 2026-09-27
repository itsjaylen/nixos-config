{ pkgs, inputs, lib, ... }:

let
  # Your custom Youer server jar
  youerPackage = pkgs.vanillaServers.vanilla.overrideAttrs (oldAttrs: {
    pname = "youer-server";
    version = "26.3";
    src = ../../../../jars/youer-26.3-956de2c9-server.jar;
  });

  # Mods from packwiz (this works reliably)
  modpack = pkgs.fetchPackwizModpack {
    url = "http://192.168.50.188:3000/itsjaylen/youer-pack/raw/branch/main/pack.toml";
    packHash = "sha256-/sMgVRe9MFSpSZmPSzzqV6kV3x60AFk/ujd4jnxZeHs=";
  };

  # Plugins: manual, explicit, reliable
  plugins = import ./youer-plugins { inherit pkgs; };
in
{
  services.minecraft-servers.servers.youer = {
    enable = true;
    package = youerPackage;
    jvmOpts = "-Xms4G -Xmx4G";

    serverProperties = { /* unchanged */ };

    # Mods: symlinked from packwiz (read-only is fine)
    symlinks = {
      "mods" = "${modpack}/mods";
    };

    # Plugins: copied as files (writable, explicit)
    files = plugins;

    # Configs: best-effort copy from packwiz derivation
    # This works IF fetchPackwizModpack includes config/, which is inconsistent.
    # For critical configs, use explicit fetchurl + files entries instead.
    extraStartPre = ''
      mkdir -p config
      if [ -d "${modpack}/config" ]; then
        cp -r --no-preserve=mode,ownership "${modpack}/config/"* config/ 2>/dev/null || true
      fi
    '';
  };
}