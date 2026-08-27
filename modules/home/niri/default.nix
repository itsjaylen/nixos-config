{ ... }:

let
  niriConfig = import ./config.nix;
  niriBinds = import ./binds.nix;
  niriRules = import ./rules.nix;
in
{
  imports = [
    ./niri.nix
  ];

  xdg.configFile."niri/config.kdl".text = ''
    ${niriConfig}
    ${niriBinds}
    ${niriRules}
  '';

  # Copy and set execution permissions for the script
  xdg.configFile."niri/scripts/uploader.sh" = {
    source = ./scripts/uploader.sh;
    executable = true;
  };

  xdg.configFile."niri/piri.toml" = {
    source = ./piri.toml;
  };
}