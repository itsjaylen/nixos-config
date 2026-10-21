{ pkgs, ... }:
{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 10;
    };

    # GCC build avoids the Clang/LTO incompatibility with nvidia-open
    kernelPackages = pkgs.linuxPackages_cachyos-gcc;

    supportedFilesystems = [ "ntfs" ];

    tmp = {
      useTmpfs = true;
      tmpfsSize = "50%";
    };
  };

  zramSwap = {
    enable = true;
    memoryPercent = 50;
    priority = 100;
  };
}