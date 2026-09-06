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
    "sha512-lMrHLv+j12LZugApnpAzANzNNtMfFbU5np5nwPas1z5jFftY9RxxcrqHcr0neNNdN4MzfL7jmXNzg1P85kWVw==")

  (plugin "CrazyEnchantments" 
    "https://cdn.modrinth.com/data/krxPuhWb/versions/6BYgadQ8/CrazyEnchantments-26.1.2-cbdc13d.jar"
    "sha512-Fs4BWR1KJ2EasrOQBzKAEfH8c9jO5cL1WNJCej147jPEw9I6uXjP4W83ruQ6tO89U7Pjf6M80oF4O89oXp3hGQ==")

  (plugin "AuraSkills" 
    "https://cdn.modrinth.com/data/uDdZAVls/versions/QOb8ZzmE/AuraSkills-2.3.12.jar"
    "sha512-us7TH/ujgX++7ljn6oZ7f9/nJj7NqK1v+sO7s6d123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef01==")

  {
    name = "plugins/BlueMap/core.conf";
    value = pkgs.runCommand "bluemap-core.conf" {
      src = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/BlueMap-Minecraft/BlueMap/master/BlueMapCommon/src/main/resources/core.conf";
        hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; 
      };
    } ''
      substitute $src $out \
        --replace "accept-download: false" "accept-download: true"
    '';
  }
]