{ pkgs, ... }:
{
  nix = {
    settings = {
      auto-optimise-store = true;
      download-buffer-size = 524288000;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://nix-community.cachix.org"
        "https://nix-gaming.cachix.org"
        # "https://attic.xuyh0120.win/lantian"
        # https://cache.nixos.org and https://nyx-cache.chaotic.cx/ are
        # added automatically by NixOS defaults and the Chaotic module.
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
        # cache.nixos.org and nyx-cache.chaotic.cx keys are added automatically.
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    git
  ];

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "26.05";
}