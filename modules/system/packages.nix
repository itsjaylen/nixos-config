# modules/system/packages.nix
{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    pciutils
    usbutils
    clinfo
    git
    tree
    eza
    fish
    bat
    btop
    nvtopPackages.nvidia
    kitty
    go
    vscode
  ];
}