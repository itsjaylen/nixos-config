{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.custom.power;
in
{
  options.custom.power = {
    maxPerformance = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Force maximum CPU/GPU performance regardless of AC/Battery state.";
    };
  };

  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
  ];

  config = {
    # 关键修复：用字面量列表强制覆盖 videoDrivers，彻底移除 "nvidia"
    services.xserver.videoDrivers = lib.mkForce [
      "modesetting"
      "fbdev"
    ];

    custom.power.maxPerformance = true;
    custom.hardware.nvidia.enable = false;

    boot = {
      kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
      kernelModules = [
        "hid-nintendo"
        "acpi_call"
      ];
      extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
      supportedFilesystems = [ "ntfs" ];
    };

    system.stateVersion = "26.05";

    environment.systemPackages = with pkgs; [
      acpi
      brightnessctl
      cpupower-gui
      powertop
    ];

    services.power-profiles-daemon.enable = !cfg.maxPerformance;

    services.upower = {
      enable = true;
      percentageLow = 20;
      percentageCritical = 5;
      percentageAction = 3;
      criticalPowerAction = "PowerOff";
    };

    services.tlp = {
      enable = cfg.maxPerformance;
      settings = {
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "performance";
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 1;
        CPU_HWP_DYN_BOOST_ON_AC = 1;
        CPU_HWP_DYN_BOOST_ON_BAT = 1;
        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "performance";
        INTEL_GPU_MIN_FREQ_ON_AC = 500;
        INTEL_GPU_MIN_FREQ_ON_BAT = 500;
      };
    };

    powerManagement.cpuFreqGovernor = if cfg.maxPerformance then "performance" else "powersave";

    virtualisation.vmVariant = {
      virtualisation = {
        memorySize = lib.mkForce 4096;
        cores = 4;
        graphics = true;
        qemu.options = [
          "-vga virtio"
          "-display sdl,gl=on"
        ];
      };

      services.displayManager.autoLogin = {
        enable = true;
        user = "jaylen";
      };
    };
  };
}