{ pkgs, inputs, lib, ... }:

let
  # Your custom Youer server jar (unchanged)
  youerPackage = pkgs.vanillaServers.vanilla.overrideAttrs (oldAttrs: {
    pname = "youer-server";
    version = "26.3";
    src = ../../../../jars/youer-26.3-956de2c9-server.jar;
  });

  # Fetch the NeoForge mods from packwiz
  modpack = pkgs.fetchPackwizModpack {
    url = "http://192.168.50.188:3000/itsjaylen/youer-pack/raw/branch/main/pack.toml";
    packHash = "sha256-/sMgVRe9MFSpSZmPSzzqV6kV3x60AFk/ujd4jnxZeHs="; # You'll get this the same way as before
  };

  # Your existing plugin imports (unchanged)
  plugins = import ./youer-plugins { inherit pkgs; };
in
{
  services.minecraft-servers.servers.youer = {
    enable = true;
    package = youerPackage;
    jvmOpts = "-Xms4G -Xmx4G";

    serverProperties = { /* unchanged */ };

    # Symlink mods from packwiz
    symlinks = {
      "mods" = "${modpack}/mods";
      "plugins" = "${modpack}/plugins";
    };
    
    # Add plugins as files (copied, so they're writable if needed)
    # Or keep them as symlinks if you don't need to edit them in-place
    files = plugins // {
      # Packwiz configs (copied at startup)
    };

    # Copy any configs from the packwiz pack
    extraStartPre = ''
      mkdir -p config
      if [ -d "${modpack}/config" ]; then
        cp -r --no-preserve=mode,ownership "${modpack}/config/"* config/
      fi
    '';
  };
}