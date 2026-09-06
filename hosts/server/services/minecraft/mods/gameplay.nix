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
    "https://cdn.modrinth.com/data/QAGBst4M/versions/KU5rZUAR/PuzzlesLib-v26.2.3-mc26.2.x-Fabric.jar"
    "3d5c0fa58f75f3cd345bc48a08a783890aab8ef01d1be113088138dda1bf79030a782dd267688c07cc2ea7a7d09710d50797416fc2292c58004cc6ff27c791bd")

  (mod "UniversalEnchants"
    "https://cdn.modrinth.com/data/DT56YDir/versions/661qCqBz/UniversalEnchants-v26.2.0-mc26.2.x-NeoForge.jar"
    "d58bede400526019c70ec8b7980e3723fbb96e943fef261443054d8b70b23728eba0a23008715ce56d9dfaf83650672684020dbf118dc94cc61b452846868247")
]
