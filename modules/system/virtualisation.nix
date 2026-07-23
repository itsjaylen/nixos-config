# modules/system/virtualisation.nix
{ config, lib, pkgs, ... }:

{
  options.mySystem.virtualisation.enable = lib.mkEnableOption "Enable libvirt / KVM virtualisation";

  config = lib.mkIf config.mySystem.virtualisation.enable {
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
    programs.virt-manager.enable = true;
  };
}