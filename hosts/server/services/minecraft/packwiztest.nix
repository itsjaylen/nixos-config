{ inputs, pkgs, lib, ... }:

let
  # Fetch your packwiz modpack from Gitea
  modpack = pkgs.fetchPackwizModpack {
    # Use the RAW URL to your pack.toml
    url = "http://192.168.50.188:3000/itsjaylen/packwiztest/src/branch/main/pack.toml";
    # You will need to get this hash (see below)
    packHash = "sha256-yzKOoHs/P54OFnSobUAvTTJIUQDUk/IW43TYnCv1odA=";
  };
in {
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services.minecraft-servers-packwiztest = {
    enable = true;
    eula = true;
    openFirewall = true;

    servers.testpack = {
      enable = true;
      # This automatically matches the server version to what's in your pack.toml
      # The `modpack.manifest` attribute reads the versions from the pack
      package = pkgs.fabricServers.${lib.replaceStrings ["."] ["_"] "fabric-${modpack.manifest.versions.minecraft}"}.override {
        loaderVersion = modpack.manifest.versions.fabric;
      };
      
      # This is where the modpack magic happens: symlink the mods
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