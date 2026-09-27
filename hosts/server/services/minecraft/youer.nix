{ pkgs, inputs, lib, ... }:

let
  youerPackage = pkgs.vanillaServers.vanilla.overrideAttrs (oldAttrs: {
    pname = "youer-server";
    version = "26.3";
    src = ../../../../jars/youer-26.3-956de2c9-server.jar;
  });

  modpack = pkgs.fetchPackwizModpack {
    url = "http://192.168.50.188:3000/itsjaylen/youer-pack/raw/branch/main/pack.toml";
    packHash = lib.fakeHash;
  };

  pluginFiles =
    let
      pluginsDir = "${modpack}/plugins";
    in
    if builtins.pathExists pluginsDir then
      let
        entries = builtins.readDir pluginsDir;
        jars = builtins.filter
          (name: (entries.${name} == "regular") && (lib.hasSuffix ".jar" name))
          (builtins.attrNames entries);
      in
      builtins.listToAttrs (map
        (name: {
          name = "plugins/${name}";
          value = "${pluginsDir}/${name}";
        })
        jars)
    else
      { };
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

    # Mods: symlinked from packwiz
    symlinks = {
      "mods" = "${modpack}/mods";
    };

    # Plugin jars: copied via `files` so the destination is writable
    files = pluginFiles;

    extraStartPre = ''
      # --- Mod configs (NeoForge) → server's config/ ---
      # Skip EssentialsC here; its configs go to plugins/ instead.
      mkdir -p config
      if [ -d "${modpack}/config" ]; then
        for entry in "${modpack}/config/"*; do
          [ -e "$entry" ] || continue
          name=$(basename "$entry")
          [ "$name" = "EssentialsC" ] && continue
          cp -rn --no-preserve=mode,ownership "$entry" config/ 2>/dev/null || true
        done
      fi

      # --- EssentialsC plugin configs → server's plugins/EssentialsC/ ---
      # `-n` = no-clobber: only seed files that don't already exist on the server,
      # so in-game edits to configs are preserved across restarts.
      # Use `-r` instead of `-rn` if you want the repo to always win.
      mkdir -p plugins
      if [ -d "${modpack}/config/EssentialsC" ]; then
        cp -rnT --no-preserve=mode,ownership "${modpack}/config/EssentialsC" plugins/EssentialsC 2>/dev/null || true
      fi
    '';
  };
}