{ lib, ... }:

{
  imports = 
    let
      # Filter out default.nix itself and non-nix files, or look for subdirs
      subFiles = builtins.attrNames (builtins.readDir ./.);
      
      toImport = lib.filter (file: 
        let
          path = ./. + "/${file}";
          type = builtins.typeOf path; # or check attributes via readDir
        in
        file != "default.nix" && (
          lib.hasSuffix ".nix" file || 
          (builtins.pathExists (path + "/default.nix"))
        )
      ) subFiles;
    in
    map (file: ./. + "/${file}") toImport;
}