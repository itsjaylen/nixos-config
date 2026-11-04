{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
    ./nvidia-ogkm.nix
  ];

  custom.hardware.nvidia.enable = true;
  powerManagement.cpuFreqGovernor = "performance";
}