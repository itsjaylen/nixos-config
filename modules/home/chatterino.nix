{ pkgs, ... }:

let
  chatterino-latest = pkgs.chatterino2.overrideAttrs (oldAttrs: {
    pname = "technorino";
    version = "7.5.5-nightly";

    src = pkgs.fetchFromGitHub {
      owner = "hvdras";
      repo = "hvdras-technorino-fork";
      rev = "ff98e4970e825b003fa1a8096836d469ebca6c43";
      hash = "sha256-zB0jkoZt6HHENe19ItcQ8EGDeIbqfPl/aO6n4XBZjys=";
      fetchSubmodules = true;
    };

    NIX_CFLAGS_COMPILE = "-Wno-error=array-bounds -Wno-array-bounds";
  });
in
{
  home.packages = [
    chatterino-latest
  ];
}