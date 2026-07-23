{ config, pkgs, ... }:

{
  # Symlink your core configuration files/folders (excluding plugins)
  xdg.configFile."noctalia/settings.json" = {
    source = ../../files/noctalia/settings.json;
    force = true;
  };

  xdg.configFile."noctalia/colors.json" = {
    source = ../../files/noctalia/colors.json;
    force = true;
  };

  xdg.configFile."noctalia/colorschemes" = {
    source = ../../files/noctalia/colorschemes;
    recursive = true;
    force = true;
  };

  # Automatically ensure the plugins directory exists on activation
  home.activation.setupNoctaliaPlugins = ''
    run mkdir -p $HOME/.config/noctalia/plugins
  '';
}