{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.custom.hardware.nvidia;
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
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
