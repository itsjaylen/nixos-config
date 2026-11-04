{ config, lib, pkgs, ... }:

let
  cfg = config.custom.hardware.nvidia;

  # Override the open kernel module source with the ogkm-patched fork.
  # This points at the submodule you checked out at branch ogkm/615.78.08.
  ogkmNvidia = let
    base = config.boot.kernelPackages.nvidiaPackages.stable;
  in base // {
    open = base.open.overrideAttrs (old: {
      src = /home/jaylen/gits/ogkm-experimental/driver;
    });
  };
in
{
  options.custom.hardware.nvidia = {
    enable = lib.mkEnableOption "NVIDIA GPU support";
  };

  config = lib.mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = true;
      nvidiaSettings = true;
      package = ogkmNvidia;
    };
  };
}