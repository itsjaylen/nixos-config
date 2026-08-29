{ config, pkgs, lib, username, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/core/bootloader.nix
    ../../modules/core/network.nix
    ../../modules/core/services.nix
    ../../modules/core/system.nix
    ../../modules/core/user.nix
    ../../modules/core/security.nix
  ];

  # Server-specific overrides
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;

  security.pam.services.login.kwallet.enable = lib.mkForce false;
  security.pam.services.swaylock.kwallet.enable = lib.mkForce false;
  environment.systemPackages = lib.mkForce [];

  # Allow the wheel group to use sudo without a password
  security.sudo.wheelNeedsPassword = false;

  users.users = {
    "${username}" = {
      extraGroups = lib.mkForce [
        "wheel"
        "networkmanager"
        "minecraft"
      ];
      shell = lib.mkForce pkgs.fish;
      openssh.authorizedKeys.keys = lib.mkForce [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCeOD9pGd9bBTlxxorOmjM23pObPLDFyjGIbgvOz+BqdLIp1ngsNB/SyQSAPoKzhpIn5mQKX414SjPfZ9e83j4PUK+7AzWey/yIn9ul9FnUmIluVNIHr3W9uIFVaZGHQBZzmzb8tqNRHNp+EnZhekJKmiZtgUMong2qh61ssUoozbbTO6+YRoZJakNZhwWeIXZD0bXEv5x0UEjv8GF0na+OOC2RTfCvNUxAvlqZmxr365tBgrvB6kpekpFKHvEhziWRCJqzdyG9mKGRnCZrVnQCXiFhauRmlxKnPngiWE2q0fM++VVUPRsT0MAvslYiLY+VxQS78okCJ9nB5YRA25CaJhR/O+o47AQsNTtjZZbt0uAnTCB537x0P08rf8qZViaa+zaYeVouHfIhbR+9f7ZCeMdHbyKEz+7yLSR/Li5Y6yo79khiBGNYZucPJuDPXpB486dwpVnnNvURXluTtNsTXcwXtyAYt8luUtkmggL8JLR1MiQnYxh96npOuzPuRQvBaDbWVelMhaEZLTpHnLFsAszZ/12zzLTO7xK6Srn0FKI36tBsj2t4CKJlm7g+orG73i8E7AN4TZZzh062x1wxUjRy7D7ibM21G+SdxnrfmOVsOxfKvVjLeHdEOi0DKHElzkXD+re5HElUAesBmBrMv2mTeYRZUBUTh/c3/YY2qw== bossjaylen145@gmail.com"
      ];
      linger = lib.mkForce true;
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
}