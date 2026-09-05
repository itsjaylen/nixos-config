{
  description = "Jaylen's SlopOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    winchain.url = "github:bytez1337/winchain";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel/release";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
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
    };

    niri-session-manager = {
      url = "github:MTeaHead/niri-session-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    piri = {
      url = "github:Asthestarsfalll/piri";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    microvm = {
          url = "github:astro/microvm.nix";
          inputs.nixpkgs.follows = "nixpkgs";
        };
  };

  outputs =
    {
      nixpkgs,
      chaotic,
      sops-nix,
      winchain,
      microvm,
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
            sops-nix.nixosModules.sops
            winchain.nixosModules.default
            {
              nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
              boot.loader.systemd-boot.winchain.enable = true;
              boot.loader.systemd-boot.winchain.partuuid = "36d12ef2-c336-4656-98f2-25b3f98a7469";
            }
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
            sops-nix.nixosModules.sops
            {
              nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
            }
            ./hosts/laptop
          ];
          specialArgs = {
            host = "laptop";
            inherit self inputs username;
          };
        };
        server = nixpkgs.lib.nixosSystem {
                  inherit system;
                  modules = [
                    chaotic.nixosModules.default
                    sops-nix.nixosModules.sops
                    microvm.nixosModules.host
                    {
                      nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
                    }
                    ./hosts/server
                  ];
                  specialArgs = {
                    host = "server";
                    inherit self inputs username;
                  };
                };
      };

      formatter.${system} = pkgs.treefmt.withConfig {
        runtimeInputs = with pkgs; [
          deadnix
          nixfmt
          taplo
          go
          shfmt
        ];
        settings.treefmt.configFiles = [ ./treefmt.toml ];
      };
    };
}