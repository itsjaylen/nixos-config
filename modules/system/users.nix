# modules/system/users.nix
{ pkgs, ... }:

{
  programs.fish.enable = true;

  users.users."jaylen" = {
    isNormalUser = true;
    description = "jaylen";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };
}