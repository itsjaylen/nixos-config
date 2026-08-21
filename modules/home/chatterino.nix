{ pkgs, ... }:

let
  chatterino-latest = pkgs.chatterino2.overrideAttrs (oldAttrs: {
    pname = "technorino";
    src = pkgs.fetchFromGitHub {
      owner = "itsjaylen";
      repo = "hvdras-technorino-fork";
      rev = "2e46bdd";
      hash = "sha256-5hAguANdB5YYq/iuL1EOmjxb25nxLM4nWl0BuNgfCpA=";
      fetchSubmodules = true;
    };
    
    # Suppress GCC 15 strict array bounds checks on Boost headers
    NIX_CFLAGS_COMPILE = "-Wno-error=array-bounds -Wno-array-bounds";
  });
in
{
  home.packages = [
    chatterino-latest
  ];
}