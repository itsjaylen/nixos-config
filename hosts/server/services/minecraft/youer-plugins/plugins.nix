{ pkgs }:

let
  plugin = name: url: sha512: {
    name = "plugins/${name}.jar";
    value = pkgs.fetchurl { inherit url sha512; };
  };

in

[
  (plugin 
    "WorldEdit" 
    "https://cdn.modrinth.com/data/1u6JkXh5/versions/J1eeOh6C/worldedit-bukkit-7.4.6-beta-02.jar" 
    "138ea8f412bf4a17104d2e090a9171e1b263c6b28a060dacda5bc78c4629e9bac1c3834cccaaa50ac87bf148a269cf9dfd46967dddedd64dc512fdf7a5db17f9")

  (plugin "ViaVersion" 
    "https://cdn.modrinth.com/data/P1OZGk5p/versions/TEgYlalY/ViaVersion-5.12.1-SNAPSHOT.jar"
    "9f23879f392a53098e1cc1a70a942bd8558ae39ab725185cf79a5dda396e748af0896416ea0357473e9c8e6b8efb330a8f4afd7ca6bd3f80861419cd67ed69e1")
]

