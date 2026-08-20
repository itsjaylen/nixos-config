{ pkgs, ... }:
{
  services = {
    gvfs.enable = true;

    udisks2.enable = true;

    fstrim.enable = true;
    fwupd.enable = true;

    dbus.enable = true;

    logind.settings.Login = {
      HandlePowerKey = "ignore";
      HandleLidSwitchDocked = "ignore";
    };
  };
}