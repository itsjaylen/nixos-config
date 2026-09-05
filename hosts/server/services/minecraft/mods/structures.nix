{ pkgs }:

let
  mod = name: url: sha512: {
    name = "mods/${name}.jar";
    value = pkgs.fetchurl { inherit url sha512; };
  };
in
[
  # Structory Family
  (mod "Structory" 
    "https://cdn.modrinth.com/data/aKCwCJlY/versions/TUbwu7eG/Structory_26.2_v1.3.7.jar" 
    "4178a15f32f6ed3d59a7eb2222a8e3f539efd7b54d8ffb790cbf1dfe5c54c6ce6ec33220e148424109c6360c4c6f081b9fbebfe74745fe3c8f05619a06ccb9ec")

  (mod "StructoryTowers" 
    "https://cdn.modrinth.com/data/j3FONRYr/versions/ziO4YIv1/Structory_Towers_26.2_v1.0.17.jar" 
    "74b1f29439e2946ef9b3f9d8d7915bc112239d5009587c7817c4f45bee7e7a48906ffcddab67f0078fe82e996093657ab874a5a0498ccc045dda4bd562bc7702")

  (mod "MoogsStructureLib" 
    "https://cdn.modrinth.com/data/1oUDhxuy/versions/p2DL6cjA/MoogsStructureLib-neoforge-26.1.2-3.2.0.jar" 
    "afcf327d3ffc0c15ce0913c6f94e12d0bfe0aa7b0b760da80a30ca677dd633ffdccc2094b3648bb3e4ff9ced31759b3713d1901faed552934c30157e0c4f1dad")
]