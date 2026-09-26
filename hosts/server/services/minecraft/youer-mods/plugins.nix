{ pkgs }:

let
  plugin = name: url: sha512: {
    name = "plugins/${name}.jar";
    value = pkgs.fetchurl { inherit url sha512; };
  };

in

[
  (plugin "WorldEdit" "https://cdn.modrinth.com/data/1u6JkXh5/versions/J1eeOh6C/worldedit-bukkit-7.4.6-beta-02.jar" "138ea8f412bf4a17104d2e090a9171e1b263c6b28a060dacda5bc78c4629e9bac1c3834cccaaa50ac87bf148a269cf9dfd46967dddedd64dc512fdf7a5db17f9")
]