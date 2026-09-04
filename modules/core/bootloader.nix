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

    tmp = {
      useTmpfs = true;
      # Automatically scales to 50% of installed RAM on any machine
      tmpfsSize = "50%"; 
    };
  };

  zramSwap = {
    enable = true;
    memoryPercent = 50;
    priority = 100; # Higher priority so zram is used before disk swap
  };
}