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

  (mod "achievements"
    "https://cdn.modrinth.com/data/bnNJHw3R/versions/bqG600ko/achievements-neoforge%2026.2-17.11.17.jar"
    "c296a3388df204c87676e54b9495c4027cf28053d8f0f6017642d822dd994cb4c1cb0809876d8cee618991103b792b43ead66d01eb7e597cdcba9be3b714bf3c")
]
