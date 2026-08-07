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

  # Use NixOS OBS program wrapper for NVENC + plugins
  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio.override {
      cudaSupport = true;
    };
    plugins = with pkgs.obs-studio-plugins; [
      obs-vaapi
    ];
  };

  environment.systemPackages = with pkgs; [
    piper
    nvidia-container-toolkit
  ];
}