{ inputs, pkgs, lib, ... }:

let
  modpack = pkgs.fetchPackwizModpack {
    url = "http://192.168.50.188:3000/itsjaylen/packwiztest/raw/branch/main/pack.toml";
    packHash = "sha256-dkVloQ0SiX490NeKQKBFVmr6VT6cmCC7/SssL20Gf2Q=";
  };
  
  # Use collectFilesAt to recursively gather all config files
  inherit (inputs.nix-minecraft.lib) collectFilesAt;
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
      
      # Use files for configs (copies them, making them writable)
      # Keep symlinks for mods (they don't need to be writable)
      symlinks = {
        "mods" = "${modpack}/mods";
      };
      
      files = collectFilesAt modpack "config" // {
        # You can add additional server-specific configs here if needed
      };

      serverProperties = {
        server-port = 25567;
        motd = "Packwiz Test Server";
        difficulty = "easy";
      };
    };
  };
}