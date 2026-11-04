{ config, lib, pkgs, ... }:

{
  hardware.nvidia.package = lib.mkForce (
    let
      base = config.boot.kernelPackages.nvidiaPackages.stable;
    in
    base // {
      open = base.open.overrideAttrs (old: {
        src = /home/jaylen/gits/ogkm-experimental/driver;
      });
    }
  );
}