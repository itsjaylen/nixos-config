{ pkgs }:

let
  plugin = name: url: sha512: {
    name = "plugins/${name}.jar";
    value = pkgs.fetchurl { inherit url sha512; };
  };
in
[
  (plugin "WorldEdit" 
    "https://cdn.modrinth.com/data/1u6JkXh5/versions/F5ea2ov3/worldedit-bukkit-7.4.5.jar" 
    "sha512-o4NJL6xr+01Dolffp7X8B2quUDpxFRtGPeT+gObz1fwRIJ6vQJe6oRXz/r8K3EDKCh7Noie4Q5tCnQpLo6Y6Tw==")

  (plugin "EssentialsX" 
    "https://cdn.modrinth.com/data/hXiIvTyT/versions/nY6VN1XH/EssentialsX-2.22.0.jar" 
    "sha512-Ry7PcZJIAXI2Q8puH5kxKX3lqgh0pUT4pxni4vfIGvge97y9OLbkPwJgqdrmq+Qsl5B+cOJDDjJv+M/xLr1hzw==")

  (plugin "BlueMap" 
    "https://cdn.modrinth.com/data/swbUV1cr/versions/K5U1ASjn/bluemap-5.23-paper.jar" 
    "sha512-qHiT11FkBd+kXhK0R73r0E7ktCP/TRCWQgB5bZDla/eJ7a8gPsMBP5JigGl7EpD7zXJUT9GSkQxF+IzlW5eLsQ==")

  (plugin "FreedomChat" 
    "https://cdn.modrinth.com/data/MubyTbnA/versions/Pqu2VLTB/FreedomChat-Paper-1.7.9.jar" 
    "94c97628e4b13762d9ba029fa1130300dccd63d31f15b5f29e96fc0586abd7392315fed8f51c772ba7e14fc4738a31d7bbd3c8c106d9929d378334ffe65c96d2")

  (plugin "CrazyEnchantments" 
    "https://cdn.modrinth.com/data/krxPuhWb/versions/6BYgadQ8/CrazyEnchantments-26.1.2-cbdc13d.jar"
    "16cf61591c4a27611a0b390907c28031f9fcb7d8eee5c2f58d9247a3fc68eeb3c5c31aa7578e935e577ae745f2d81b5c001927d6e36f328853b06ffd894df179")

  (plugin "AuraSkills" 
    "https://cdn.modrinth.com/data/uDdZAVls/versions/QOb8ZzmE/AuraSkills-2.3.12.jar"
    "baceed31fca3817fbeee58e9de86bc7d2eff273ae4208aba7d7e5a95941fa5bbf0439eb3ece4a261135d669fc6575433ef8c40ac0830ff3138eba4cd64aeba27")
  
]