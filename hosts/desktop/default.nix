{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
  ];

  # Chaotic-Nyx's overlay is now provided automatically by
  # `chaotic.nixosModules.default` in flake.nix, so no manual overlay is needed.

  custom.hardware.nvidia.enable = true;
  powerManagement.cpuFreqGovernor = "performance";
}