{ config, pkgs, lib, username, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
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
    serverAddr = "https://localhost:6443";
    tokenFile = config.sops.secrets."k3s/node-token".path;

    extraFlags = [
      # Label the node so you can pin small Go/Rust services to it
      "--node-label=role=small-services"

      # Optional: give it a stable name instead of the hostname
      "--node-name=k3s-agent"

      # Reduce kubelet's log noise and reserve a bit of RAM for the OS
      "--kubelet-arg=system-reserved=memory=512Mi"
      "--kubelet-arg=kube-reserved=memory=256Mi"
      "--kubelet-arg=eviction-hard=memory.available<256Mi"
    ];
  };

  # Handy for debugging the node locally
  environment.systemPackages = with pkgs; [
    kubectl
    cri-tools
  ];
}