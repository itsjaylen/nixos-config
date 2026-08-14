{ pkgs, ... }:

{
  networking.hostName = "desktop";

  boot.kernelPackages = pkgs.linuxPackages_cachyos;

  virtualisation.vmVariant = {
    virtualisation = {
      memorySize =  3814;
      cores = 3;
      };
    };
  imports = [
  ];

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
     enable = true;
     enable32Bit = true;
   };

  hardware.cpu.amd.updateMicrocode = true;
  hardware.bluetooth.enable = true;
  hardware.graphics.enable = true;
  hardware.nvidia = {
    videoAcceleration = true;
    open = false;
    modesetting.enable = true;
    branch = "latest";
  };
}
