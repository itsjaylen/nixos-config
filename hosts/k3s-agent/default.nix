{ config, pkgs, lib, username, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core/network.nix
    ../../modules/core/services.nix
    ../../modules/core/system.nix
    ../../modules/core/security.nix
    ../../modules/core/nh.nix
    ../../modules/core/sops.nix
    ./networking.nix
  ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = false;
  };
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;

  users.users = {
    "${username}" = {
      isNormalUser = true;
      description = "${username}";

      extraGroups = [
        "wheel"
        "networkmanager"
      ];

      shell = pkgs.fish;

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPCHsjBvdZ7/oqWa0YK1dD6NLSgr1d+eJk9YnrD3tAGj bossjaylen145@gmail.com"
      ];

      linger = true;
    };
  };

  programs.fish.enable = true;

  nix.settings.allowed-users = [
    "@wheel"
  ];

  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;

  # --- K3s agent ---
  services.k3s = {
    enable = true;
    role = "agent";
    serverAddr = "https://192.168.50.188:6443";
    tokenFile = config.sops.secrets."k3s/node-token".path;

    extraFlags = [
      "--node-label=role=small-services"
      "--kubelet-arg=system-reserved=memory=512Mi"
      "--kubelet-arg=kube-reserved=memory=256Mi"
      "--kubelet-arg=eviction-hard=memory.available<256Mi"
    ];
  };

  environment.systemPackages = with pkgs; [
    kubectl
    cri-tools
  ];
}