# modules/system/extras.nix
{ config, lib, pkgs, ... }:

{
  options.mySystem.extras.enable = lib.mkEnableOption "Extra desktop apps, databases, and utilities";

  config = lib.mkIf config.mySystem.extras.enable {
    environment.systemPackages = with pkgs; [
      filezilla
      lazygit
      calibre
      easyeffects
      kdePackages.qtstyleplugin-kvantum 
      nwg-look
    ];
  };
}