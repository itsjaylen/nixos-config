{ config, lib, pkgs, inputs, ... }:

{
  options.mySystem.gaming.enable = lib.mkEnableOption "Gaming setup with Steam, Millennium, Lutris, MangoHud, and Prism Launcher";

  config = lib.mkIf config.mySystem.gaming.enable {
    nixpkgs.overlays = [ inputs.millennium.overlays.default ];

    programs.steam = {
      enable = true;
      package = pkgs.millennium-steam;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true; 
    };

    programs.gamemode = {
      enable = true;
      enableRenice = true;
    };

    environment.systemPackages = with pkgs; [
      lutris
      mangohud
      protonup-qt
      prismlauncher
      gamescope
      gamemode
      mimalloc
      protontricks
      heroic
      lunar-client
      
      (inputs.vortex.packages.${pkgs.system}.vortex.overrideAttrs (old: {
        pnpmDeps = old.pnpmDeps.overrideAttrs (oldDeps: {
          outputHash = "sha256-iTeMC/DnMwKN3DhWMikywKcrExmmAcYl6tzmCPt7noY=";
        });
      }))
    ];
  };
}