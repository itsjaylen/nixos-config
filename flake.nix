{
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
  description = "Jaylen's SlopOS configuration";
||||||| parent of 78ad2bb (started remove of slop)
  description = "Jaylen's Modular NixOS Configuration";

  nixConfig = {
    extra-substituters = [ "https://vortex-nix.cachix.org" ];
    extra-trusted-public-keys = [
      "vortex-nix.cachix.org-1:7+ZVU0umNp8sz1JqZV/bRcbVgemNuNtzN5KiJxihFRY="
    ];
  };
=======
  description = "Modular NixOS configuration for Desktop and Laptop";
>>>>>>> 78ad2bb (started remove of slop)
||||||| parent of 91e4c16 (base config more)
  description = "Modular NixOS configuration for Desktop and Laptop";
=======
  description = "SlopOS configuration without slop.";
>>>>>>> 91e4c16 (base config more)
||||||| parent of 121ad01 (restructure: repair broken refs and update tracking)
  description = "SlopOS configuration without slop.";
=======
  description = "Jaylen's SlopOS configuration";
>>>>>>> 121ad01 (restructure: repair broken refs and update tracking)

  inputs = {
<<<<<<< HEAD
<<<<<<< HEAD
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    chaotic.url = "github:chaotic-cx/nyx";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-flatpak.url = "github:gmodena/nix-flatpak";

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    maple-mono = {
      url = "github:subframe7536/maple-font?ref=v7.8";
      flake = false;
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    superfile.url = "github:yorukot/superfile";
    zen-browser.url = "github:0xc000022070/zen-browser-flake/beta";
    millennium = {
      url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
||||||| parent of 78ad2bb (started remove of slop)
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
=======
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
||||||| parent of 121ad01 (restructure: repair broken refs and update tracking)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
=======
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    chaotic.url = "github:chaotic-cx/nyx";
>>>>>>> 121ad01 (restructure: repair broken refs and update tracking)

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-flatpak.url = "github:gmodena/nix-flatpak";

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    maple-mono = {
      url = "github:subframe7536/maple-font?ref=v7.8";
      flake = false;
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
<<<<<<< HEAD

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
>>>>>>> 78ad2bb (started remove of slop)
||||||| parent of 121ad01 (restructure: repair broken refs and update tracking)

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
=======
    superfile.url = "github:yorukot/superfile";
    zen-browser.url = "github:0xc000022070/zen-browser-flake/beta";
    millennium = {
      url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
      # Ensure it follows your nixpkgs version to prevent duplicate dependencies
      inputs.nixpkgs.follows = "nixpkgs";
>>>>>>> 121ad01 (restructure: repair broken refs and update tracking)
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
<<<<<<< HEAD

  outputs =
    {
      nixpkgs,
      chaotic,
      self,
      ...
    }@inputs:
    let
      username = "jaylen";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            chaotic.nixosModules.default
            ./hosts/desktop
          ];
          specialArgs = {
            host = "desktop";
            inherit self inputs username;
          };
        };
        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            chaotic.nixosModules.default
            ./hosts/laptop
          ];
          specialArgs = {
            host = "laptop";
            inherit self inputs username;
          };
        };
      };
    };
||||||| parent of 91e4c16 (base config more)
=======

  outputs =
    {
      nixpkgs,
      chaotic,
      self,
      ...
    }@inputs:
    let
      username = "jaylen";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            chaotic.nixosModules.default
            ./hosts/desktop
          ];
          specialArgs = {
            host = "desktop";
            inherit self inputs username;
          };
        };
        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            chaotic.nixosModules.default
            ./hosts/laptop
          ];
          specialArgs = {
            host = "laptop";
            inherit self inputs username;
          };
        };
      };
    };
>>>>>>> 91e4c16 (base config more)
}