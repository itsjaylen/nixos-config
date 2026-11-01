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
    ../../modules/core/nvidia.nix
    ../tools.nix
  ];

  # Turn on the NVIDIA module (your existing module is already correct
  # for the 1660 Super — Turing, open = true is right).
  custom.hardware.nvidia.enable = true;

  users.users = {
    "${username}" = {
      isNormalUser = true;
      description = "${username}";

      extraGroups = [
        "wheel"
        "networkmanager"
        "video"
        "render"
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

  # GPU box: keep /tmp on disk so big model loads / builds don't eat RAM.
  boot.tmp.useTmpfs = lib.mkForce false;

  # CUDA toolchain + container support for playing with GPU workloads.
  environment.systemPackages = with pkgs; [
    cudaPackages.cudatoolkit
    nvidia-container-toolkit
  ];

  # Optional but handy: node exporter so your existing grafana/prometheus
  # on the optiplex can scrape this box.
  services.prometheus.exporters.node = {
    enable = true;
    port = 9100;
    enabledCollectors = [ "systemd" "processes" ];
  };
}