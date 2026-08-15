# modules/hardware/nvidia.nix
{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.hardware.nvidia;
in {
  options.mySystem.hardware.nvidia = {
    enable = lib.mkEnableOption "NVIDIA GPU drivers and container support";
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.config.allowUnfree = true;

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    hardware.nvidia-container-toolkit.enable = true;

    environment.systemPackages = with pkgs; [
      piper
      nvidia-container-toolkit
    ];
  };
}