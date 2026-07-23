# modules/core.nix
{ pkgs, ... }:

{
  imports = [
    ./system/network.nix
    ./system/users.nix
    ./system/services.nix
    ./system/packages.nix
    ./system/extras.nix
    ./system/vpn.nix
    ./system/virtualisation.nix
    ./system/niri.nix
  ];

  # Bootloader & Kernel
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Custom Module Switches
  mySystem.gaming.enable = true;
  mySystem.extras.enable = true;
  mySystem.vpn.enable = true;
  mySystem.virtualisation.enable = true;
  mySystem.niri.enable = false;

  # Enable Flakes CLI support
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "26.05";
}