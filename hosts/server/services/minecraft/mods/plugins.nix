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
]