{ config, pkgs, lib, host, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/core/bootloader.nix
    ../../modules/core/network.nix
    ../../modules/core/services.nix
    ../../modules/core/system.nix
    ../../modules/core/user.nix
    ../../modules/core/security.nix
  ];

  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;

  # Disable GUI wallet services not needed on a headless server
  security.pam.services.login.kwallet.enable = lib.mkForce false;
  security.pam.services.swaylock.kwallet.enable = lib.mkForce false;

  # Remove the KDE wallet system packages introduced by security.nix
  environment.systemPackages = lib.mkForce [];
}