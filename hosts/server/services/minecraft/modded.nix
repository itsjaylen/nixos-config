{ pkgs, ... }:

let
  youerServerJar = pkgs.fetchurl {
    url = "https://api.mohistmc.com/project/youer/26.2/builds/latest/download";
    sha512 = "sha512-JoXYlni7aJUqXxIQcaCttQDRGkHM6H5knpiqzVu4Hf9U2Njoi4ngy+FZi8y0lVE0+WXmttExYEsu4RfumP0O0g==";
  };

  youerServerPkg = pkgs.stdenv.mkDerivation {
    pname = "youer-server";
    version = "26.2";
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/bin
      cat << EOF > $out/bin/minecraft-server
      exec ${pkgs.jdk21}/bin/java -Xms2G -Xmx2G -jar ${youerServerJar} nogui
      EOF
      chmod +x $out/bin/minecraft-server
    '';
  };
in
{
  services.minecraft-servers.servers.youer = {
    enable = true;
    package = youerServerPkg;

    serverProperties = {
      server-port = 25566;
      motd = "Youer NeoForge + Paper Hybrid";
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