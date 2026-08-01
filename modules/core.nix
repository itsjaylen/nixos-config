{ pkgs, inputs, ... }:

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

  # Bootloader & CachyOS Kernel Configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Apply CachyOS overlay and pick a pre-built kernel package
  nixpkgs.overlays = [
    inputs.nix-cachyos-kernel.overlays.pinned
  ];

  # Example: Latest CachyOS kernel (you can swap this out for other variants like 
  # pkgs.cachyosKernels.linuxPackages-cachyos-lts, -bore, -eevdf, etc.)
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

  # Custom Module Switches
  mySystem.gaming.enable = true;
  mySystem.extras.enable = true;
  mySystem.vpn.enable = true;
  mySystem.virtualisation.enable = true;
  mySystem.niri.enable = true;
  programs.nix-ld.enable = true;

  # Enable Flakes CLI support
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = [ "root" "jaylen" ];

  system.stateVersion = "26.05";
}