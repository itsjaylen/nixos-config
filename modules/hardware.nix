{
  config,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  hardware.cpu.amd.updateMicrocode = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Enable NVIDIA Container Toolkit & CDI support on NixOS
  hardware.nvidia-container-toolkit.enable = true;

  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      features = {
        cdi = true;
      };
    };
  };

  services.ratbagd.enable = true;

  environment.systemPackages = with pkgs; [
    piper
    nvidia-container-toolkit
  ];
}