{ config, pkgs, lib, username, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./services
    ../../modules/core/bootloader.nix
    ../../modules/core/network.nix
    ../../modules/core/services.nix
    ../../modules/core/system.nix
    ../../modules/core/security.nix
    ../../modules/core/nh.nix
    ../../modules/core/sops.nix
  ];

  users.users = {
    "${username}" = {
      isNormalUser = true;
      description = "${username}";
      extraGroups = [
        "wheel"
        "networkmanager"
        "minecraft"
      ];
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPCHsjBvdZ7/oqWa0YK1dD6NLSgr1d+eJk9YnrD3tAGj bossjaylen145@gmail.com"
      ];
      linger = true;
    };

    minecraft = {
      isSystemUser = true;
      group = "minecraft";
      home = "/var/lib/minecraft";
      createHome = true;
      description = "Minecraft daemon user";
    };
  };

  users.groups.minecraft = {};

  programs.fish.enable = true;

  nix.settings.allowed-users = [ "@wheel" ];

  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
  boot.tmp.useTmpfs = lib.mkForce false;
}