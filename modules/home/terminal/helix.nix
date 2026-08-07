{ config, pkgs, lib, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      # Go & C
      gopls
      golangci-lint
      clang-tools

      # System Administration & Config LSPs/Formatters
      nixd                  
      alejandra             
      bash-language-server       
      yaml-language-server  
      vscode-langservers-extracted 
      marksman              
    ];
  };

  # Force-override the default editor session variable to use Helix (hx)
  home.sessionVariables.EDITOR = lib.mkForce "hx";
  home.sessionVariables.VISUAL = lib.mkForce "hx";

  # Force-override config files with your custom files
  xdg.configFile."helix/config.toml" = {
    source = lib.mkForce ../../../files/helix/config.toml;
    force = true;
  };

  xdg.configFile."helix/languages.toml" = {
    source = lib.mkForce ../../../files/helix/languages.toml;
    force = true;
  };
}