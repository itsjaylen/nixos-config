{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    niri
    awww
    grimblast
    grim
    slurp
    wl-clip-persist
    cliphist
    glib
    wayland
    direnv
    inputs.niri-session-manager.packages.${pkgs.system}.default
    inputs.piri.packages.${pkgs.system}.default
  ];
}