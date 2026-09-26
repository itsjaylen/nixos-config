{ pkgs }:

let
  mod = name: url: sha512: {
    name = "mods/${name}.jar";
    value = pkgs.fetchurl { inherit url sha512; };
  };
in

[
  (mod "DistantHorizons-3" 
    "https://cdn.modrinth.com/data/uCdwusMi/versions/gfi11b05/DistantHorizons-3.3.2-26.3-fabric-neoforge.jar" 
    "78a378d5ec117b330923015fe6517fcfabac3db464b3321d7a25b6e5d77dd11225c83b4707e83ac720507c5ac718a1639101332295a1c580413cf2498f472959")

  (mod "Tectonic" 
    "https://cdn.modrinth.com/data/lWDHr9jE/versions/sS6alco3/tectonic-3.0.30-neoforge-26.3.jar" 
    "4f94f6c557ffe1e41715410eb423b1ada8ccb315e335952fff9128248a43c41be56c06874d007a3d438ef7cf8c32939e81f9d866752c8eb289ae1b52ea0901c0")

  (mod "lithostitched" 
    "https://cdn.modrinth.com/data/XaDC71GB/versions/y9AtQNh2/lithostitched-2.0.4-neoforge-26.3.jar"
    "5e258016f04a755509cc179baf814245993fba6eb99dde3adb45f052b6e4f1a675183cc35cd3abc257bbac13f70bde10333bb0bc073867729940d87eeab77c86")
]
