{ config, lib, pkgs, ... }:

{
  # 1. Define the switch option
  options.mySystem.gaming.enable = lib.mkEnableOption "Gaming setup with Steam, Lutris, and MangoHud";

  # 2. Apply settings ONLY if the switch is set to true
  config = lib.mkIf config.mySystem.gaming.enable {
    # Enable Steam properly (NixOS handles firewall ports & 32-bit drivers)
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    # Install Gaming Utilities
    environment.systemPackages = with pkgs; [
      lutris       # Launcher for non-Steam games (GOG, Epic, etc.)
      mangohud     # Performance & FPS overlay
      protonup-qt  # Easy GUI to download custom GE-Proton versions
    ];
  };
}
