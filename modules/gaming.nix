# modules/system/gaming.nix
{ config, lib, pkgs, ... }:

{
  options.mySystem.gaming.enable = lib.mkEnableOption "Gaming setup with Steam, Millennium, Lutris, MangoHud, and Prism Launcher";

  config = lib.mkIf config.mySystem.gaming.enable {
    # 1. Import the Millennium overlay globally so pkgs.millennium-steam becomes available
    nixpkgs.overlays = [ inputs.millennium.overlays.default ]; # Note: ensure `inputs` is passed to this module if it isn't already, or handle it via flake arguments

    # 2. Configure Steam using the Millennium custom package wrapper
    programs.steam = {
      enable = true;
      package = pkgs.millennium-steam;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    # Install remaining gaming utilities & launchers
    environment.systemPackages = with pkgs; [
      lutris
      mangohud
      protonup-qt
      prismlauncher
    ];
  };
}