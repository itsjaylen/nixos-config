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
  ];

  # Bootloader & Kernel
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Custom Module Switches
  mySystem.gaming.enable = true;
  mySystem.extras.enable = true; # Set to false on your laptop!

  # Enable Flakes CLI support
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "26.05";
}