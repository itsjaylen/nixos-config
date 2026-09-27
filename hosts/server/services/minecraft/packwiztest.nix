{ inputs, pkgs, lib, ... }:

let
  modpack = pkgs.fetchPackwizModpack {
    url = "http://192.168.50.188:3000/itsjaylen/packwiztest/raw/branch/main/pack.toml";
    packHash = "sha256-dkVloQ0SiX490NeKQKBFVmr6VT6cmCC7/SssL20Gf2Q=";
  };

  sparkConfig = pkgs.fetchurl {
    url = "http://192.168.50.188:3000/itsjaylen/packwiztest/raw/branch/main/server-overrides/config/spark/config.json";
    hash = "sha256-cjA5coVWHZoFpVWxsdigpaPsIzHfNhTx8nD0z2NMAhk=";
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

      symlinks = {
        "mods" = "${modpack}/mods";
      };

      files = {
        "config/spark/config.json" = sparkConfig;
      };

      serverProperties = {
        server-port = 25567;
        motd = "Packwiz Test Server";
        difficulty = "easy";
      };
    };
  };
}