{ pkgs }:

let
  mod = name: url: sha512: {
    name = "mods/${name}.jar";
    value = pkgs.fetchurl { inherit url sha512; };
  };
in

[
  (mod "moreenchantments" 
    "https://cdn.modrinth.com/data/LbDPuvYD/versions/euADRaBO/moreenchantments-1.5.jar" 
    "88674486913c29f8cfa06d33aeeb3d0c4afa7b77040b396a041fe11681ee88619e0812bd2f38c2eaba6ef4f17bfa8c111b0f4734add4c9584d4a1d4157c6fa5f")


  (mod "PuzzlesLib"
    "https://cdn.modrinth.com/data/QAGBst4M/versions/eI8PIwKt/PuzzlesLib-v26.2.2-mc26.2.x-NeoForge.jar"
    "f93924c361c09555439575133cbb7b46c1a187602f4a5f1ffa0d185b326d06602184765fd75c0edd293129b5a866287c876c508f6f571b41cdfc20849b271847")

  (mod "UniversalEnchants"
    "https://cdn.modrinth.com/data/DT56YDir/versions/661qCqBz/UniversalEnchants-v26.2.0-mc26.2.x-NeoForge.jar"
    "d58bede400526019c70ec8b7980e3723fbb96e943fef261443054d8b70b23728eba0a23008715ce56d9dfaf83650672684020dbf118dc94cc61b452846868247")
]
