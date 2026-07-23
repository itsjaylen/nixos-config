{
  description = "Jaylen's Modular NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    zen-browser.url = "github:youwen5/zen-browser-flake";
    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
    

    # 1. Add Home Manager input
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Moved noctalia-qs correctly inside the inputs block
    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Added noctalia-qs to the outputs arguments list
  outputs = { self, nixpkgs, home-manager, spicetify-nix, millennium, noctalia-qs, ... }@inputs: {
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      # Pass inputs to NixOS system modules (core.nix, desktop.nix, etc.)
      specialArgs = { inherit inputs; };

      modules = [
        ./hardware-configuration.nix
        ./modules/core.nix
        ./modules/hardware.nix
        ./modules/desktop.nix
        ./modules/audio.nix
        ./modules/gaming.nix

        # 2. Add Home Manager as a module
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          # Pass inputs to Home Manager modules (home.nix)
          home-manager.extraSpecialArgs = { inherit inputs; };

          # Pass user config to Home Manager
          home-manager.users."jaylen" = import ./modules/home.nix;
        }
      ];
    };
  };
}