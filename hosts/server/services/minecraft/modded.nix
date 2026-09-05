{ pkgs, ... }:

let
  youerServerJar = pkgs.fetchurl {
    url = "https://api.mohistmc.com/project/youer/26.2/builds/latest/download";
    sha512 = "sha512-JoXYlni7aJUqXxIQcaCttQDRGkHM6H5knpiqzVu4Hf9U2Njoi4ngy+FZi8y0lVE0+WXmttExYEsu4RfumP0O0g==";
  };
in
{
  services.minecraft-servers.servers.youer = {
    enable = true;
    package = pkgs.jdk21;
    jvmOpts = "-Xms2G -Xmx2G -jar ${youerServerJar} nogui";
    
    # Explicitly match user/group to avoid root socket ownership mismatch
    user = "minecraft";
    group = "minecraft";
  
    serverProperties = {
      server-port = 25566;
      motd = "Youer NeoForge + Paper Hybrid";
    };
  };
}