{ pkgs, lib, ... }:

{
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = lib.mkForce "niri";
  services.printing.enable = true;
  security.polkit.enable = true;
  qt.enable = true; # Ensures Qt/KDE integration elements are loaded
}