{ pkgs }:

let
  mod = name: url: sha512: {
    name = "mods/${name}.jar";
    value = pkgs.fetchurl { inherit url sha512; };
  };
in

[
  (mod "RoughlyEnoughItems" 
    "https://cdn.modrinth.com/data/nfn13YXA/versions/BoY0Dky0/RoughlyEnoughItems-26.2.820.jar" 
    "f674095e009274852b1a392221d900b3b1f553f520c8b930fa34b064761fb2d3fed33a0216c32cb5951b70208cf2f505122229fe6109039306d5108f38927939")

  (mod "architectury" 
    "https://cdn.modrinth.com/data/lhGA9TYQ/versions/9D1cNuR2/architectury-neoforge-21.0.7.jar" 
    "c095a42c903da7cfc7ed7e668ee768bbf4143eab3ecfced1a731158c6f606c7b222e6db44fa5952422fc529e4015786e67637127ede6c684ea8b7a502e834091")

  (mod "cloth_config" 
    "https://cdn.modrinth.com/data/9s6osm5g/versions/zErG1kOw/cloth-config-26.2.155.jar" 
    "3f7ea8108d8c0463764e419f3fe7d4d7f586b6fb7d2578de85f709b70d59587060a07c0fe02d5b79ed37e74850dd088caace40f8baefb4402df8139d076dc662")
]