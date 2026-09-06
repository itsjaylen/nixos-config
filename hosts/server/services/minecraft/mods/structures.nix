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

  # Moogs Structure Family
  (mod "MoogsStructureLib" 
    "https://cdn.modrinth.com/data/1oUDhxuy/versions/vpzwwarX/MoogsStructureLib-neoforge-26.2-3.2.0.jar" 
    "7239163b7518a43c2b617796b070c48d35473407e6664aee5d83447083f9413b557c67f14d495cf9e2caa7f09a00827cb4adaa5ee19f5a3014b492ddee00f92b")

  (mod "MoogsEndStructures" 
    "https://cdn.modrinth.com/data/r4PuRGfV/versions/JW80uvhz/MoogsEndStructures-1.21-2.0.3.jar" 
    "eaf67a1854fe548f9537dbb0ec60a913d0126980db24840318ced7c3dd0740979b2821100d6acd37e85a73aca6a190d410b4d78d4503dc68e36b23a6dfcc7b17")

  (mod "MoogsVoyagerStructures" 
    "https://cdn.modrinth.com/data/OQAgZMH1/versions/F4KldqbX/MoogsVoyagerStructures-universal-1.21-5.1.1.jar" 
    "c05abf7a226da3a59e7eb4889fa78aef7e391ccc075551a3545d4b24ee908958dca13c87408c95dfa8e659d0dc5fbabf99dd1d034ad258eb4937bb984ae767c8")

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

  (mod "dungeons_and_taverns" 
    "https://cdn.modrinth.com/data/tpehi7ww/versions/9wgjmpuF/dungeons-and-taverns-5.3.2.jar" 
    "9afd93bedb405941a1213727c7a4015fa19cbff99ce30e2f814b442e255852096902b2a27d4dcd1960f6b4fbe8af8dec8af93d592bc2fe963973deee1b190937")

  (mod "dungeons_and_taverns_ocean_monument_overhaul"
    "https://cdn.modrinth.com/data/z6GJ3ycD/versions/2fYxegFC/dungeons-and-taverns-ocean-monument-overhaul-2.2.1.jar"
    "4cad18af7396d8a037bef8ad4efba53b8c07271fcbb0289189786b3dead2a72d229b50c1ea94154ab2bec2211302ecf753bdee5a1cf820d121cea55a568e0fd1")

  (mod "dungeons-and-taverns-ancient-city-overhaul"
    "https://cdn.modrinth.com/data/DNuNq5bb/versions/rqmj1SPX/dungeons-and-taverns-ancient-city-overhaul-3.4.jar"
    "c6a63f8fb1ddf7a3ed95729b0c68ed8238ddabd9bc1517b955e77565fb877a2c085cf1858bb8b287f4ed8d4c492d3aab65f4de2f780de34fe8379c7f9dfb14db")

  (mod "more_mobs"
    "https://cdn.modrinth.com/data/HJR6V0I2/versions/UErmjjDF/more_mobs-v1.5.10-mc1.14-26.2.9-mod.jar"
    "ceb950f9ad05d026c76a5d1cc66a2eb4724c3486217721e3c609e619d20e228008d0c639af12c1560d787ec371938b3372fa788e6a49c499fdf5f02c487b668d")
  
]