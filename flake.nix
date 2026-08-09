{
  description = "Jaylen's Modular NixOS Configuration";

  nixConfig = {
    extra-substituters = [ "https://vortex-nix.cachix.org" ];
    extra-trusted-public-keys = [
      "vortex-nix.cachix.org-1:7+ZVU0umNp8sz1JqZV/bRcbVgemNuNtzN5KiJxihFRY="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nirimod.url = "github:srinivasr/nirimod";
    
    # Added CachyOS Kernel input (release branch maps to binary cache builds)
    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel/release";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";

    # Added Vortex-nix input
    vortex = {
      url = "github:crowquillx/vortex-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Noctalia v5 (main branch)
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, spicetify-nix, millennium, zen-browser, noctalia, nirimod, nix-cachyos-kernel, vortex, ... }@inputs: {
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