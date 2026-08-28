{ pkgs, ... }:
{
  services.xserver.enable = true;

  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm; # Qt6 SDDM
    };

    defaultSession = "niri";
  };

  environment.systemPackages = with pkgs; [
    # Required for Wayland + QEMU rendering under Qt6 SDDM
    kdePackages.qtdeclarative
    kdePackages.qtsvg
    kdePackages.layer-shell-qt
  ];

  services.libinput.enable = true;
  systemd.settings.Manager.DefaultTimeoutStopSec = "10s";
}
