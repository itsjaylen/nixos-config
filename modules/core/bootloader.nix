{ pkgs, ... }:
{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 10;
    };

    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

    supportedFilesystems = [ "ntfs" ];

    # Save SSD writes by mounting /tmp in RAM
    tmp = {
      useTmpfs = true;
      tmpfsSize = "32G"; 
    };
  };

  zramSwap = {
    enable = true;
    memoryPercent = 50;
    priority = 5;
  };
}