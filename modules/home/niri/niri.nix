{ pkgs, ... }:

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
  ];

  # Do NOT use inputs.niri.homeModules.niri or programs.niri.settings here
  # Keep config.nix, binds.nix, and rules.nix in default.nix as you currently have them.
}