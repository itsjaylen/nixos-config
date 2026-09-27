{ inputs, pkgs, lib, ... }:

let
  modpack = pkgs.fetchPackwizModpack {
    url = "http://192.168.50.188:3000/itsjaylen/packwiztest/raw/branch/main/pack.toml";
    packHash = "sha256-dkVloQ0SiX490NeKQKBFVmr6VT6cmCC7/SssL20Gf2Q=";
  };
in {
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;

    servers.testpack = {
      enable = true;
      package = (pkgs.fabricServers.${lib.replaceStrings ["."] ["_"] "fabric-${modpack.manifest.versions.minecraft}"}.override {
        jre_headless = pkgs.openjdk25_headless;
      }).override {
        loaderVersion = modpack.manifest.versions.fabric;
      };

      # Keep mods symlinked (read-only is fine)
      symlinks = {
        "mods" = "${modpack}/mods";
      };

      # Copy configs at startup so Spark can write to them
      extraStartPre = ''
        mkdir -p config
        if [ -d "${modpack}/config" ]; then
          cp -r --no-preserve=mode,ownership "${modpack}/config/"* config/ 2>/dev/null || true
        fi
      '';

      serverProperties = {
        server-port = 25567;
        motd = "Packwiz Test Server";
        difficulty = "easy";
      };
    };
  };
}