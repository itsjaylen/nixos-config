{ lib, ... }:

{
  imports = 
    let
      dirFiles = builtins.readDir ./.;
      
      isNixFile = name: type: type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix";
      
      validFiles = lib.filterAttrs isNixFile dirFiles;
    in
      map (name: ./${name}) (builtins.attrNames validFiles);
}