{ pkgs, lib, ... }:

{
  networking.hostName = "laptop";

  hardware.graphics.enable = true;

  # Ensure laptop uses open-source modesetting instead of the desktop's NVIDIA drivers
    services.xserver.videoDrivers = lib.mkForce [ "modesetting" ];
    hardware.nvidia-container-toolkit.enable = lib.mkForce false;

  # Force standard binary-cached linux kernel (no compilation required)
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;

  # Power management
  services.tlp.enable = true;
  services.power-profiles-daemon.enable = false;
  services.upower.enable = true;
  services.thermald.enable = true;

  # Touchpad support
  services.libinput.enable = true;

  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 4096;
      cores = 4;
      qemu.options = [
        "-vga virtio"
        "-display default,show-cursor=on"
      ];
    };
  };
}