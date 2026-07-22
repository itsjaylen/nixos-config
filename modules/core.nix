# modules/core.nix
{ pkgs, ... }:

{
  imports = [
    ./system/network.nix
    ./system/users.nix
    ./system/services.nix
    ./system/packages.nix
  ];

  # Bootloader & Kernel
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Custom Module Switches
  mySystem.gaming.enable = true;

  # Enable Flakes CLI support
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "26.05";
}