{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.millennium.overlays.default
  ];

  programs = {
    steam = {
      enable = true;

      package = pkgs.millennium-steam;

      gamescopeSession.enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };

    gamescope = {
      enable = true;
      capSysNice = true;
      args = [
        "--rt"
        "--expose-wayland"
      ];
    };
  };

  hardware.steam-hardware.enable = true;
}