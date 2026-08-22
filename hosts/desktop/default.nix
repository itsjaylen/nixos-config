{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
  ];

  nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];

  custom.hardware.nvidia.enable = true;
  powerManagement.cpuFreqGovernor = "performance";
}