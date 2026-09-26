{ pkgs }:

let
  plugins = import ./plugins.nix { inherit pkgs; };
in
builtins.listToAttrs (plugins)
