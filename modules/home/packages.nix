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

    # Custom Technorino Fork
        (chatterino2.overrideAttrs (oldAttrs: {
          pname = "technorino";
          src = fetchFromGitHub {
            owner = "itsjaylen";
            repo = "hvdras-technorino-fork";
            rev = "2e46bdd";
            hash = "sha256-5hAguANdB5YYq/iuL1EOmjxb25nxLM4nWl0BuNgfCpA=";
            fetchSubmodules = true;
          };
        }))
  ];
}
