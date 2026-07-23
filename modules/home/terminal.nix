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
    settings = {
      add_newline = false;
      format = "$directory$git_branch$rust$python\n$character";
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    CHROMIUM_FLAGS = "--disable-gpu-compositing";
    NVM_DIR = "$HOME/.nvm";
  };
}