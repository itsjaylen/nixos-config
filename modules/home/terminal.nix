# modules/home/terminal.nix
{ ... }:

{
  imports = [
    ./terminal/default.nix
  ];

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    xdg.configFile."starship.toml".source = ../../../files/starship.toml;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    CHROMIUM_FLAGS = "--disable-gpu-compositing";
    NVM_DIR = "$HOME/.nvm";
  };
}