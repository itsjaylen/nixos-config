# modules/home/neovim.nix
{ pkgs, ... }:

{
  # Install Neovim and build dependencies for NvChad, Mason, and Treesitter
  home.packages = with pkgs; [
    neovim
    git
    gcc
    ripgrep
    fd
    nodejs
    tree-sitter
  ];

  # Fetch NvChad Starter config directly into ~/.config/nvim
  xdg.configFile."nvim".source = pkgs.fetchFromGitHub {
    owner = "NvChad";
    repo = "NvChad";
    rev = "v2.5";
    hash = "sha256-N345B0PqL026SAnlR1kQk3yB9AAnfH4Uq12xO7mQ2Bw=";
  };
}