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

    # Mods stay symlinked (read-only is fine)
    symlinks = {
      "mods" = "${modpack}/mods";
    };

    # Plugins: use `files` so the module copies the jar into plugins/ on each start.
    # Unlike a symlink, this gives a writable location, so plugins can create
    # their own config/data folders (e.g. plugins/faststats/, plugins/bStats/).
    files = {
      "plugins/EssentialsC-4.3.1.2-all.jar" = "${modpack}/plugins/EssentialsC-4.3.1.2-all.jar";
    };
  };
}