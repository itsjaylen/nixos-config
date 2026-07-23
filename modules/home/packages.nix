# modules/home/packages.nix
{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    ripgrep
    fd
    fzf
    tree
    eza
    fish
    ffmpeg
    mdcat
    ouch
    legcord
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.noctalia-qs.packages.${pkgs.system}.default

    # Custom Technorino Fork
    (chatterino2.overrideAttrs (oldAttrs: {
      pname = "technorino";
      src = fetchFromGitHub {
        owner = "hvdras";
        repo = "hvdras-technorino-fork";
        rev = "6242a423f50ac78871e355302c703cccd8100133";
        hash = "sha256-ZIABRQtpPsijQM7F+qRMvqhiVGAnkDqxnLeZusgoZOs=";
        fetchSubmodules = true;
      };
    }))
  ];
}