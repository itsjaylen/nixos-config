{ pkgs, ... }:

let
  youerPackage = pkgs.vanillaServers.vanilla.overrideAttrs (oldAttrs: {
    pname = "youer-server";
    version = "26.2";
    src = pkgs.fetchurl {
      url = "https://api.mohistmc.com/project/youer/26.2/builds/latest/download";
      sha256 = "47116296239b3f114c82166fd3a45ca26c8875e277906dd8289099628af09926";
    };
  });
in
{
  services.minecraft-servers.servers.neoforge = {
    enable = true;
    
    package = youerPackage;
    jvmOpts = "-Xms2G -Xmx2G";

    serverProperties = {
      server-port = 25566;
      motd = "Modded";
      enforce-secure-profile = false;
    };

    symlinks = {
          "mods/Spark.jar" = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/l6YH9Als/versions/DdMsOH3O/spark-1.10.173-neoforge.jar";
            sha512 = "f40b72761c2137debe90c836a32918e4e3aa2629db4b50e9b78bdcacdbe6e484682ba7e11535bee7fcf581abe944948dde48dda37ee45d3966a5d7e450191173";
          };
    
          "plugins/WorldEdit.jar" = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/1u6JkXh5/versions/F5ea2ov3/worldedit-bukkit-7.4.5.jar";
            sha512 = "sha512-o4NJL6xr+01Dolffp7X8B2quUDpxFRtGPeT+gObz1fwRIJ6vQJe6oRXz/r8K3EDKCh7Noie4Q5tCnQpLo6Y6Tw==";
          };
    
          "plugins/EssentialsX.jar" = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/hXiIvTyT/versions/nY6VN1XH/EssentialsX-2.22.0.jar";
            sha512 = "sha512-Ry7PcZJIAXI2Q8puH5kxKX3lqgh0pUT4pxni4vfIGvge97y9OLbkPwJgqdrmq+Qsl5B+cOJDDjJv+M/xLr1hzw==";
          };
    
          "plugins/Essentials/config.yml" = pkgs.runCommand "essentials-config.yml" {
            src = pkgs.fetchurl {
              url = "https://raw.githubusercontent.com/EssentialsX/Essentials/2.22.0/Essentials/src/main/resources/config.yml";
              sha256 = "sha256-M4As04JRLI8dHUtBBY8gMBR8RtbxRaIRBMlQioG7MhA=";
            };
          } ''
            substitute $src $out \
              --replace "unsafe-enchantments: false" "unsafe-enchantments: true"
          '';

          "plugins/BlueMap.jar" = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/swbUV1cr/versions/K5U1ASjn/bluemap-5.23-paper.jar";
                  sha512 = "sha512-qHiT11FkBd+kXhK0R73r0E7ktCP/TRCWQgB5bZDla/eJ7a8gPsMBP5JigGl7EpD7zXJUT9GSkQxF+IzlW5eLsQ==";
                };

          "plugins/FreedomChat.jar" = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/MubyTbnA/versions/Pqu2VLTB/FreedomChat-Paper-1.7.9.jar";
                  sha512 = "94c97628e4b13762d9ba029fa1130300dccd63d31f15b5f29e96fc0586abd7392315fed8f51c772ba7e14fc4738a31d7bbd3c8c106d9929d378334ffe65c96d2";
                };
          
            "plugins/Terralith.jar" = pkgs.fetchurl {
                    url = "//cdn.modrinth.com/data/8oi3bsk5/versions/lqrGyTjO/Terralith_26.2_v2.6.4_Neoforge.jar";
                    sha512 = "b66ade8d34cb61af8174eac4af9905d741a456fdd4c32f1674d106a47094ae560cd9652cf4904ebff591c931134dc3d307fbfa0904503d202e1048289b6f8d3b";
                  };      
                
        };
  };
}