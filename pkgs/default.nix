{
  inputs,
  pkgs,
  system,
  ...
}:
{
  maple-mono-custom = pkgs.callPackage ./maple-mono { inherit inputs; };
  rustlog = pkgs.callPackage ./rustlog { inherit inputs; };
  amethyst-mod-manager = pkgs.callPackage ./amethyst-mod-manager { inherit inputs; };
}