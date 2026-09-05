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
    "https://cdn.modrinth.com/data/1oUDhxuy/versions/vpzwwarX/MoogsStructureLib-neoforge-26.2-3.2.0.jar" 
    "7239163b7518a43c2b617796b070c48d35473407e6664aee5d83447083f9413b557c67f14d495cf9e2caa7f09a00827cb4adaa5ee19f5a3014b492ddee00f92b")

  (mod "MoogsEndStructures" 
    "https://cdn.modrinth.com/data/r4PuRGfV/versions/JW80uvhz/MoogsEndStructures-1.21-2.0.3.jar" 
    "eaf67a1854fe548f9537dbb0ec60a913d0126980db24840318ced7c3dd0740979b2821100d6acd37e85a73aca6a190d410b4d78d4503dc68e36b23a6dfcc7b17")

  (mod "MoogsVoyagerStructures" 
    "https://cdn.modrinth.com/data/OQAgZMH1/versions/HZpL7DX5/MoogsVoyagerStructures-universal-1.20-5.1.1.jar" 
    "87cdc2b07c6297fab15805f78f8cf9b1de99fffd0baf5b6f0ed605f56b71bb2962586d20f7407755508680ed060d6e6fe26a8f714ead3a60d7538d3f44e13e6e")

  (mod "MoogsNetherStructures" 
    "https://cdn.modrinth.com/data/nGUXvjTa/versions/RFeEhpv4/MoogsNetherStructures-1.21-3.0.0.jar" 
    "e9ea480ace4d91b03babcc63b9006c917c2e591a33102811f425ef5c8c3fc45926552ea1afbb8fbfc092a88862a804a0f1d99c75ae9a0c791d1ccdc71b49406a")

  (mod "MoogsSoaringStructures" 
    "https://cdn.modrinth.com/data/RJCLIx7k/versions/i1RQPVjQ/MoogsSoaringStructures-1.21-2.1.2.jar" 
    "85e13d55a2f191e0dc88c5e84927cfe0a48878673a6c42badb67ab7189c76112ecfa9ac3d68b2c015f7208086e2873ae69fa029f4a3d31c3bc5170568bf33e56")

  (mod "MoogsMissingVillages" 
    "https://cdn.modrinth.com/data/spZb29SD/versions/1HLHTaPT/MoogsMissingVillages-1.21-2.1.2.jar" 
    "a63bec27e807a0c6b6d844be885eb86694075f653c7ec3deb801a9dfadec37b6c80af5469f52f617adac37c764f1b7f8b2ebcae0a96a913874f6115dce3bcdba")

  (mod "MoogsTemplesReimagined" 
    "https://cdn.modrinth.com/data/UNanzCXS/versions/2yTTKOV5/MoogsTemplesReimagined-universal-1.21-2.0.2.jar" 
    "330f311b2eab579e9eb6ee9f14c58536ebc5eb2f9058254bb2584ec7fa4480aafe7bd26ee3ef0d5de5be4d555386258b2302e825af5d7e7a1b8544940c4cc364")

  (mod "MoogsMineshaftsReimagined" 
    "https://cdn.modrinth.com/data/z25hqseO/versions/2Sq5BzBC/MoogsMineshaftsReimagined-1.21-1.0.1.jar" 
    "3f556c8196d8779cf3d17a2243efe54ec60aa6be8964e2b63e5778b7df05b3171c7164d476c76cb0ed029b83c2116142dfc7ef51ba6d37b8ef184b7141d16d98")

  (mod "MoogsPaths" 
    "https://cdn.modrinth.com/data/HDB8pnki/versions/ElSzi7CW/moogs_paths-neoforge-26.2-1.0.4.jar" 
    "95e3538a42f028ad64aa5eaa4120fc01441649fef5bc128722b8f80a9ec542100af39187ce3f352c1603bd3bf264c420977c1aa558544e1808d790eef4593763")

  (mod "MoogsOceanStructures" 
    "https://cdn.modrinth.com/data/ZKBkklMv/versions/4b7dG23l/MoogsOceanStructures-universal-1.21-1.1.0.jar" 
    "08227ce0a5acf5a6da8c2eba901ac30397ed56cf19249e4d0158998f7b8dbc0b45c6ed92590c80304e48804f7f5457062cbbfd1e9ca1febd4723a0f4267ae9e1")
]