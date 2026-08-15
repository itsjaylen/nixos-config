{
  description = "Jaylen's Modular NixOS Multi-Host Configuration";

  nixConfig = {
    extra-substituters = [ "https://vortex-nix.cachix.org" ];
    extra-trusted-public-keys = [
      "vortex-nix.cachix.org-1:7+ZVU0umNp8sz1JqZV/bRcbVgemNuNtzN5KiJxihFRY="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nirimod.url = "github:srinivasr/nirimod";

    # CachyOS Kernel input
    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel/release";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";

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

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      # Shared home-manager configuration block
      sharedHomeManager = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs; };
        home-manager.users."jaylen" = import ./modules/home.nix;
        home-manager.backupFileExtension = "bak";
      };

      # Common NixOS modules used across all machines
      commonModules = [
        ./modules/core.nix
        ./modules/audio.nix
        ./modules/desktop.nix
        ./modules/system/niri.nix
        ./modules/gaming.nix
        home-manager.nixosModules.home-manager
        sharedHomeManager
      ];
    in
    {
      nixosConfigurations = {
        # Desktop Host Configuration
        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = commonModules ++ [
            ./hosts/desktop/configuration.nix
            ./hosts/desktop/hardware-configuration.nix
            ./modules/hardware.nix
            ./modules/gaming.nix
          ];
        };

        # Laptop Host Configuration
        laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = commonModules ++ [
            ./hosts/laptop/configuration.nix
            ./hosts/laptop/hardware-configuration.nix
          ];
        };
      };
    };
}