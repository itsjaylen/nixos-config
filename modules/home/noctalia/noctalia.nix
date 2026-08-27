{ config, pkgs, inputs, ... }:
{

  imports = [
      inputs.noctalia.homeModules.default
    ];
  
  programs.noctalia.enable = true;

  xdg.configFile."noctalia/settings.json".text = builtins.readFile ./settings.json;
}