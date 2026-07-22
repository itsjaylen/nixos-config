# modules/home/neovim.nix
{ pkgs, ... }:

{
  # Only list building tools/dependencies here, avoiding duplicate neovim package collisions
  home.packages = with pkgs; [
    git
    gcc
    ripgrep
    fd
    nodejs
    tree-sitter
  ];

  # Use the main branch archive or a stable commit hash for NvChad starter template to avoid tarball version mismatch
  xdg.configFile."nvim".source = pkgs.fetchFromGitHub {
    owner = "NvChad";
    repo = "starter";
    rev = "main";
    hash = "sha256-N345B0PqL026SAnlR1kQk3yB9AAnfH4Uq12xO7mQ2Bw="; # We'll let nix fetch it or update hash if needed
  };
}