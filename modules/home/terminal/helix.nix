{ config, pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = false;
  };

  # Link the main config and languages files
  xdg.configFile."helix/config.toml" = {
    source = ../../../files/helix/config.toml;
    force = true;
  };

  xdg.configFile."helix/languages.toml" = {
    source = ../../../files/helix/languages.toml;
    force = true;
  };

  # Link the custom runtime folder
  xdg.configFile."helix/runtime" = {
    source = ../../../files/helix/runtime;
    force = true;
  };
}