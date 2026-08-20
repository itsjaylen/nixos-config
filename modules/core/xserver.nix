{ pkgs, username, ... }:
{
  services.xserver.enable = false;

  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
    };

    autoLogin = {
      enable = true;
      user = "${username}";
    };

    defaultSession = "niri";
  };

  services.libinput.enable = true;

  systemd.settings.Manager.DefaultTimeoutStopSec = "10s";
}