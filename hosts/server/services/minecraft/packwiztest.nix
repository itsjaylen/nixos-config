{ inputs, pkgs, lib, ... }:

let
  modpack = pkgs.fetchPackwizModpack {
    # Changed to use the raw URL format
    url = "https://192.168.50.188:3000/itsjaylen/packwiztest/raw/branch/main/pack.toml";
    packHash = "sha256-yzKOoHs/P54OFnSobUAvTTJIUQDUk/IW43TYnCv1odA=";
  };
in {
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  # Fixed: removed the extra "-packwiztest" suffix
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;

    servers.testpack = {
      enable = true;
      package = pkgs.fabricServers.${lib.replaceStrings ["."] ["_"] "fabric-${modpack.manifest.versions.minecraft}"}.override {
        loaderVersion = modpack.manifest.versions.fabric;
      };
      
      symlinks = {
        "mods" = "${modpack}/mods";
      };

      serverProperties = {
        server-port = 25567;
        motd = "Packwiz Test Server";
        difficulty = "easy";
      };
    };
  };
}