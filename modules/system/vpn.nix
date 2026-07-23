# modules/system/vpn.nix
{ config, lib, pkgs, ... }:

{
  options.mySystem.vpn.enable = lib.mkEnableOption "Enable Mullvad VPN service";

  config = lib.mkIf config.mySystem.vpn.enable {
    services.mullvad-vpn.enable = true;
    environment.systemPackages = with pkgs; [
      mullvad
    ];
  };
}