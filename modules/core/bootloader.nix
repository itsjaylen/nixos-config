{ pkgs, ... }:
{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 10;
    };

    # Point to xddxdd's CachyOS kernel variant
    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

    supportedFilesystems = [ "ntfs" ];
  };
}
