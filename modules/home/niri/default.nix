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
}