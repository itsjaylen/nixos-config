# modules/home/neovim.nix
{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Dependencies required by NvChad, Mason, and treesitter
  home.packages = with pkgs; [
    git
    gcc
    ripgrep
    fd
    nodejs
    tree-sitter
  ];

  # Fetch NvChad Starter config to ~/.config/nvim if you want fresh NvChad v2.5
  xdg.configFile."nvim".source = pkgs.fetchFromGitHub {
    owner = "NvChad";
    repo = "NvChad";
    rev = "v2.5";
    hash = "sha256-ZZpDdJJ3yH4ZgsoEQ7O/A0E1DUO10rSx6dlebPQWotE=";
  };
}