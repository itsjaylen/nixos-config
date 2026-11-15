{
  inputs,
  pkgs,
  ...
}:
{
  maple-mono-custom = pkgs.callPackage ./maple-mono { inherit inputs; };
  rustlog = pkgs.callPackage ./rustlog { inherit inputs; };
  swiftdl = pkgs.callPackage ./swiftdl { inherit inputs; };
}