{ pkgs, inputs, ... }:
{
  nixpkgs = {
    overlays = [
      (
        _final: prev:
        (import ../../pkgs {
          inherit inputs;
          inherit pkgs;
          inherit (prev) system;
        })
      )
    ];
  };
}
