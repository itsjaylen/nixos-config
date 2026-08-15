{ pkgs, ... }:

{
  networking.hostName = "desktop";
  mySystem.gaming.enable = true;
  mySystem.hardware.nvidia.enable = true;

  # Systemd-boot for UEFI desktop
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # High performance CPU Governor
  powerManagement.cpuFreqGovernor = "performance";
}