{ pkgs }:

let
  plugins = import ./plugins.nix { inherit pkgs; };
  worldgen = import ./worldgen.nix { inherit pkgs; };
  structures = import ./structures.nix { inherit pkgs; };
  utility = import ./utility.nix { inherit pkgs; };
in
builtins.listToAttrs (plugins ++ worldgen ++ structures ++ utility)