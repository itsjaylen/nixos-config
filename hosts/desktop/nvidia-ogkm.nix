{ config, lib, pkgs, ... }:

let
  base = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    version = "620.70.06";
    sha256_64bit = "sha256-KRGOOr0IwHVZvMo9nHYjjQOUkK8DYqLlvPy+cgSv1LE=";
    openSha256 = "sha256-dV8vzniUl3UJoG2Q3KdoUJigLRuQeTniUfB670gb1Mw=";
    settingsSha256 = "sha256-CFBRmXFJ9eAf5BRlHMBolahz1Pshr9giI7zcZC29oZ8=";
    usePersistenced = false;
  };

  # Patches exported from the ogkm repo you cloned.
  # The patches in patches/620.70.06/ are already in the correct format for git am.
  ogkmPatches = map (p: /home/jaylen/gits/ogkm-experimental/patches/620.70.06/${p}) [
    # List the patch filenames you want to apply here, e.g.:
    # "0001-nvidia-refuse-page-less-dma-buf-exports-for-static-importers-too.patch"
    # "0002-nvidia-don-t-give-a-second-GPU-the-DMA-addresses-of-an-imported-buffer.patch"
    # ...
  ];
in
{
  hardware.nvidia.package = base // {
    open = base.open.overrideAttrs (old: {
      patches = (old.patches or []) ++ ogkmPatches;
    });
  };
}