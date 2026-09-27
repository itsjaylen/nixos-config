{ pkgs, inputs, lib, ... }:

let
  # Your custom Youer server jar
  youerPackage = pkgs.vanillaServers.vanilla.overrideAttrs (oldAttrs: {
    pname = "youer-server";
    version = "26.3";
    src = ../../../../jars/youer-26.3-956de2c9-server.jar;
  });

  # Mods + plugins from packwiz.
  # ⚠️ Update packHash whenever the packwiz repo changes:
  #   nix-prefetch-url --unpack "http://192.168.50.188:3000/itsjaylen/youer-pack/raw/branch/main/pack.toml"
  #   nix hash convert --to sri --hash-algo sha256 <output>
  # (or use `nix run nixpkgs#nix-prefetch -- <url>` to get SRI directly)
  modpack = pkgs.fetchPackwizModpack {
    url = "http://192.168.50.188:3000/itsjaylen/youer-pack/raw/branch/main/pack.toml";
    packHash = "sha256-DHysMSP0JiWf9gQZSB65mVoZ8aS7IqJs7Hw5/lISZzY=";
  };

  # Dynamically discover plugin jars in the packwiz store path.
  # - Defensive: if plugins/ doesn't exist, returns {} instead of failing eval.
  # - No hardcoded filenames: packwiz version bumps are picked up automatically.
  # - Copied (not symlinked) via `files`, so plugins get a writable location
  #   for their own data dirs (e.g. plugins/faststats/, plugins/bStats/).
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

    # Mods: symlinked. Read-only is fine — NeoForge doesn't write into mods/.
    symlinks = {
      "mods" = "${modpack}/mods";
    };

    # Plugins: copied via `files` so the destination is a real writable
    # directory. Essential because plugins like EssentialsC create their
    # own data/config folders at runtime, which a Nix store symlink forbids.
    files = pluginFiles;

    # Configs from packwiz: best-effort copy.
    extraStartPre = ''
      mkdir -p config
      if [ -d "${modpack}/config" ]; then
        cp -r --no-preserve=mode,ownership "${modpack}/config/"* config/ 2>/dev/null || true
      fi
    '';
  };
}