# modules/system/packages.nix
{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  programs.firefox.enable = true;

  # Essential system-level utilities for hardware and terminal management
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
    rustc
    cargo
    vscode
    unzip
    mpv
    earlyoom
  ];
}