{ pkgs }:

let
  plugins = import ./plugins.nix { inherit pkgs; };
  gameplay = import ./gameplay.nix { inherit pkgs; };
in
builtins.listToAttrs (plugins ++ gameplay)
