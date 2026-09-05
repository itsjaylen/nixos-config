{ pkgs, ... }:

{
  services.minecraft-servers.servers.neoforge = {
    enable = true;
    package = pkgs.neoforgeServers.neoforge-26_2.overrideAttrs (old: {
      src = pkgs.fetchurl {
        url = "https://api.mohistmc.com/project/youer/26.2/builds/latest/download";
        sha256 = "47116296239b3f114c82166fd3a45ca26c8875e277906dd8289099628af09926";
      };
    });
    
    jvmOpts = "-Xms2G -Xmx2G";

    serverProperties = {
      server-port = 25566;
      motd = "Modded Youer Server";
    };

    symlinks = {
      "mods/FerriteCore.jar" = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/uXXizFIs/versions/LtVvw4uS/ferritecore-9.0.0-neoforge.jar";
        sha512 = "e96a99ac5539f56a1f4cd109d62b668ebd5283f0068491ede956f52e67023beba7abe2e40021499352ffc41ead950bebcabce7792352249a1b45c5dccb3cf99c";
      };

      "mods/Spark.jar" = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/l6YH9Als/versions/DdMsOH3O/spark-1.10.173-neoforge.jar";
        sha512 = "f40b72761c2137debe90c836a32918e4e3aa2629db4b50e9b78bdcacdbe6e484682ba7e11535bee7fcf581abe944948dde48dda37ee45d3966a5d7e450191173";
      };
    };
  };
}