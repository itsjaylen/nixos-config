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
    nh
    p7zip
    mdcat
    jq
    ouch
    legcord
    xwayland
    xwayland-satellite
    nerd-fonts.jetbrains-mono
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.nirimod.packages.${pkgs.stdenv.hostPlatform.system}.default

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