{ config, pkgs, lib, ... }:

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
    custom.power.maxPerformance = true;
    custom.hardware.nvidia.enable = false;

    boot = {
      kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
      kernelModules = [ "hid-nintendo" "acpi_call" ];
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

    # VM overrides inside config block
    virtualisation.vmVariant = {
          virtualisation = {
            memorySize = lib.mkForce 4096;
            cores = 4;
    
            # Enable QEMU display window and virtio GPU
            graphics = true;
            qemu.options = [
              "-vga virtio"
              "-display sdl,gl=on" # or "-display default"
            ];
          };
    
          # Auto-login to bypass password/keyring prompts in test VM
          services.displayManager.autoLogin = {
            enable = true;
            user = "jaylen";
          };
        };
  };
}