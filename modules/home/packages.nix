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
    unrar
    arrpc
    legcord
    xwayland
    xwayland-satellite
    grim
    slurp
    golangci-lint
    wl-clipboard
    wine
    nerd-fonts.jetbrains-mono
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

    # Custom Technorino Fork
        (chatterino2.overrideAttrs (oldAttrs: {
          pname = "technorino";
          src = fetchFromGitHub {
            owner = "itsjaylen";
            repo = "hvdras-technorino-fork";
            rev = "b7a1ac6";
            hash = "sha256-tQhlzmgYarukwYz8Hi6QV2TkORTXPMyoOtALKGjRUNo=";
            fetchSubmodules = true;
          };
        }))
  ];
}
