{
  description = "Jaylen's Modular NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nirimod.url = "github:srinivasr/nirimod";
    
    # Added CachyOS Kernel input (release branch maps to binary cache builds)
    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel/release";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia/legacy-v4";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, spicetify-nix, millennium, zen-browser, noctalia, nirimod, nix-cachyos-kernel, ... }@inputs: {
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      # Pass inputs down to modules
      specialArgs = { inherit inputs; };

      modules = [
        ./hardware-configuration.nix
        ./modules/core.nix
        ./modules/hardware.nix
        ./modules/desktop.nix
        ./modules/audio.nix
        ./modules/gaming.nix
        ./modules/system/niri.nix

        # Add Home Manager as a module
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          # Pass inputs to Home Manager modules
          home-manager.extraSpecialArgs = { inherit inputs; };

          # Pass user config to Home Manager
          home-manager.users."jaylen" = import ./modules/home.nix;
          home-manager.backupFileExtension = "bak";
        }
      ];
    };
  };
}