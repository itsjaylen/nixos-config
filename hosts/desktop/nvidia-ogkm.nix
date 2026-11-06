{ config, lib, pkgs, ... }:

{
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    version = "615.78.08";
    sha256_64bit = "sha256-Pj9t3cLudnoIGFMAr3vjyyhuznZpjS3eNSRZl4LQf/4=";
    openSha256 = "sha256-HBINiOjL0ZJLIAJeNIBYHBnwgUXtNwPPtnFpAI1YwF4=";
    settingsSha256 = "sha256-inDRpG02sdDgHmlqgu/DsgK8OFdOt1fZIYyXdhlGC/c=";
    usePersistenced = false;
  };
}