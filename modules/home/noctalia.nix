{ config, pkgs, ... }:

{
  xdg.configFile."noctalia/settings.json" = {
    source = ../../files/noctalia/settings.json;
    force = true;
  };

  xdg.configFile."noctalia/colors.json" = {
    source = ../../files/noctalia/colors.json;
    force = true;
  };

  home.activation.setupNoctaliaPlugins = ''
    run mkdir -p $HOME/.config/noctalia/plugins
  '';
}