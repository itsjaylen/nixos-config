{
  inputs,
  pkgs,
  system,
  ...
}:
{
  maple-mono-custom = pkgs.callPackage ./maple-mono { inherit inputs; };
  rustlog = pkgs.callPackage ./rustlog { inherit inputs; };
}