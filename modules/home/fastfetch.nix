{ config, pkgs, ... }:

{
  xdg.configFile."fastfetch/config.jsonc" = {
    source = ../../files/fastfetch/config.jsonc;
    force = true;
  };

  xdg.configFile."fastfetch/images" = {
    source = ../../files/fastfetch/images;
    force = true;
    recursive = true; 
  };
}