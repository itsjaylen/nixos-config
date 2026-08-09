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
    satty
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
            rev = "779f5fd";
            hash = "sha256-ud5nLXtA7vntTpNMtjI0YRi1+fFUcme1w3u5RfmpJNM=";
            fetchSubmodules = true;
          };
        }))
  ];
}
