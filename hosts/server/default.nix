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
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI... your_key_here"
      ];
      linger = true; # Keeps user systemd services running after logout
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

  # Nix settings
  nix.settings.allowed-users = [ "@wheel" ]; # Allows your admin user and root

  # Server overrides
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
  boot.tmp.useTmpfs = lib.mkForce false; # Routes /tmp to SSD to save RAM on 24GB node
}