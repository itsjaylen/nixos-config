{ config, pkgs, ... }:

{
  hardware.cpu.amd.updateMicrocode = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Enable the libratbag daemon required for mouse configuration
  services.ratbagd.enable = true;

  # Install the Piper GUI application
  environment.systemPackages = with pkgs; [
    piper
  ];
}
