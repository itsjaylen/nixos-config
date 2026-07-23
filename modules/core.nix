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
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

  # CachyOS Binary Caches (Prevents building the kernel from source)
  nix.settings.substituters = [
    "https://cache.xinux.uz"
    "https://attic.xuyh0120.win/lantian"
  ];
  nix.settings.trusted-public-keys = [
    "cache.xinux.uz:BXCrtqejFjWzWEB9YuGB7X2MV4ttBur1N8BkwQRdH+0="
    "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
  ];

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