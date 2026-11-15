{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
    ./nvidia-ogkm.nix
    ./elden-ring.nix
  ];

  custom.hardware.nvidia.enable = true;
  powerManagement.cpuFreqGovernor = "performance";
}