{ pkgs, ... }:
{
  home.packages = [ pkgs.superfile ];

  xdg.configFile."superfile/config.toml".source = ./config.toml;
}
