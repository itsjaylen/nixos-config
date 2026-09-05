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

  # Moog's Voyager Structures & Library Dependency

  # YUNG's Collection & API
  (mod "YungsApi" 
    "https://cdn.modrinth.com/data/Ua7DFN59/versions/K3Dp2T0P/YungsApi-1.21.1-NeoForge-5.1.8.jar" 
    "83520e057a949ed6e8dcee33984ae0eef83c2e57d001ffbbba0b51090176608f7378327ece773312543cd8cbb802f951b7c24b57f3ab6cf19d2be10b47af30d0")

  (mod "YungsBetterDungeons" 
    "https://cdn.modrinth.com/data/o1C1Dkj5/versions/nYyCiHOI/YungsBetterDungeons-26.1.2-NeoForge-6.1.0.jar" 
    "45a51d3bbd88611ac12bf198ad1d2736998c91283e9cb509d1d20d4ea9894427404bdb1d72826981b7a73ccae8b489996e54308f9656c8cc195bc404c227824d")

  (mod "YungsBetterNetherFortresses" 
    "https://cdn.modrinth.com/data/Z2mXHnxP/versions/XJWhXWgn/YungsBetterNetherFortresses-26.1.2-NeoForge-4.1.0.jar" 
    "dc167a75a8a8b32ede142d33aa8ad4584d4361d76e21c350ae87b5be26fea77de9df5e185d4928facab3fbe3c3b368e772fe16cf549af665eda09e5103e6f49d")

  (mod "YungsBetterMineshafts" 
    "https://cdn.modrinth.com/data/HjmxVlSr/versions/8MMBHdSy/YungsBetterMineshafts-26.1.2-NeoForge-6.1.0.jar" 
    "babcbabfb041f28cd64650dfc579671fc7d314b225f8dba9672c21c8420735fd99c9ffd354d98a6652ebc3e27d72d6830f23985b88c0ef983116c7eb311d2ed9")

  (mod "YungsBetterOceanMonuments" 
    "https://cdn.modrinth.com/data/3dT9sgt4/versions/ovS6Blc2/YungsBetterOceanMonuments-26.1.2-NeoForge-5.1.0.jar" 
    "2e154f3e336b7f22f1604ad9dff1b721f7bba311889b01caabd6e8b6cada65da8043f338a73ddfeb362df78d4f7533e52e2627d9101474856416fbe142a5c495")

  (mod "YungsBetterJungleTemples" 
    "https://cdn.modrinth.com/data/z9Ve58Ih/versions/CkjyYvLs/YungsBetterJungleTemples-26.1.2-NeoForge-4.1.0.jar" 
    "c4a9c218111dd6ed4c429562444b644b9fed4f9e015f35424bf32bd2c41641f123d56ff1d81f6f60b87028e0021c0cd24873126f78ae095c6684f91c46915373")

  (mod "YungsBetterEndIsland" 
    "https://cdn.modrinth.com/data/2BwBOmBQ/versions/iGCLljb0/YungsBetterEndIsland-26.1.2-NeoForge-4.1.0.jar" 
    "21df39ce903fbcd9a8705847bbb06f46d6792835d1aca891a664388fb9104dcccbbba37973bc211e79f86d4fa2ac5f352bd6b14dca89ae030ac1397336ba18da")

  (mod "YungsBetterStrongholds" 
    "https://cdn.modrinth.com/data/kidLKymU/versions/r6czw4RL/YungsBetterStrongholds-26.1.2-NeoForge-6.1.0.jar" 
    "1733152eb159299f06a583fa1295cd8c7803b1ce33456459793b6f2496075b11f8c8c784664eed472f3b74e201d5651c25e94ac8a0e428759a8aed97464e84af")

  (mod "YungsBetterWitchHuts" 
    "https://cdn.modrinth.com/data/t5FRdP87/versions/9ZLhxr84/YungsBetterWitchHuts-26.1.2-NeoForge-5.1.0.jar" 
    "3c29d3a78d10fd9be657d888ca3d93847bf93fb61ac21374ba3ed4c7a7fb856059410288a124790276cf86d66f6d47522e717194132913efa36634a45d46bc74")

  (mod "YungsBetterDesertTemples" 
    "https://cdn.modrinth.com/data/XNlO7sBv/versions/PdYp5G62/YungsBetterDesertTemples-26.1.2-NeoForge-5.1.0.jar" 
    "d9996a8cfb6684cb147ece0ed512736eb6581687d22e26ecf02c7ce033171d6eda744cc85fb3ef6e005619350002e3a22fca1f6289d3d09dd6167ed3cb6e1359")

  (mod "YungsBridges" 
    "https://cdn.modrinth.com/data/Ht4BfYp6/versions/fi6Ilg6W/YungsBridges-26.1.2-NeoForge-6.1.0.jar" 
    "7da18f1b8ff6a781886cd634ef6d15d5518f1608358d1d0d0cf01dc33ddbbfc5e5782cd122afc4fdc7e0b7a1ddff7591931dd5ed0e62f3ac8aa43600853737fe")

  (mod "YungsExtras" 
    "https://cdn.modrinth.com/data/ZYgyPyfq/versions/nxaj9k0R/YungsExtras-26.1.2-NeoForge-6.1.0.jar" 
    "cca70df46c3cb455601cf0fb55076a5e9be01dbe58f88a418a54b8c0c570ea254d746eec28dd4886daa212a2eecc061a3d2a77118070dafd6ada28adeebf9222")

  (mod "YungsCaveBiomes" 
    "https://cdn.modrinth.com/data/cs7iGVq1/versions/oXLoOQEW/YungsCaveBiomes-26.1.2-NeoForge-4.1.1.jar" 
    "b506d8a05f916b5690582f511a64ffb26e413f86faa7b7fc718729f8d4e351262494a8637dee569e458219a46e507bff6443b96320472cb0539cd13524a61b05")

  (mod "YungsBetterCaves" 
    "https://cdn.modrinth.com/data/Dfu00ggU/versions/Feo6YOjN/YungsBetterCaves-1.21.1-NeoForge-3.1.6.jar" 
    "a5fa3881a32a96c25c8012aac347221363792d68491ae1f6e26d345264f7acff7c7562d6c96e0ee2f00c63ad50351742763a740f0965cc9ca0b97808f8847bba")
]