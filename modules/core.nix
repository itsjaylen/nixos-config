{ config, pkgs, inputs, ... }:

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

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';

  # --- ADD THESE LINES TO TRUST THE CACHYOS BINARY CACHE ---
  nix.settings.substituters = [
    "https://attic.xuyh0120.win/lantian"
  ];
  nix.settings.trusted-public-keys = [
    "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
  ];
  # ---------------------------------------------------------

  # Apply CachyOS overlay and pick a pre-built kernel package
  nixpkgs.overlays = [
    inputs.nix-cachyos-kernel.overlays.pinned
  ];

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

  system.stateVersion = "26.05";
}