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

  
]
