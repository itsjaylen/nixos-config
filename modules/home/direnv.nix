{ pkgs, ... }:

{
  programs.direnv = {
    enable = true;

    enableFishIntegration = true;

    nix-direnv.enable = true;
  };

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set -g fish_greeting ""
    '';
  };
}
