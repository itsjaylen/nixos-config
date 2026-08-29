{ config, pkgs, lib, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/core/bootloader.nix
    ../../modules/core/network.nix
    ../../modules/core/services.nix
    ../../modules/core/system.nix
    ../../modules/core/user.nix
    ../../modules/core/security.nix
  ];

  # Force the server to use the standard upstream latest kernel instead of CachyOS
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
}