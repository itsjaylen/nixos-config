{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
  ];

  custom.hardware.nvidia.enable = true;
  powerManagement.cpuFreqGovernor = "performance";
}