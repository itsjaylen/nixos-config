{ pkgs, ... }:

{
  # Enable Nix Flakes and modern CLI commands
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader defaults
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Time zone and localization
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  # Common user definition
  users.users.jaylen = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    shell = pkgs.zsh;
  };

  # Common system packages across desktop & laptop
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    vim
    htop
  ];

  programs.zsh.enable = true;

  system.stateVersion = "24.11"; # Adjust to match your installed NixOS version
}