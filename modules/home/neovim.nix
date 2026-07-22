# modules/home/neovim.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    git
    gcc
    ripgrep
    fd
    nodejs
    tree-sitter
  ];

  xdg.configFile."nvim".source = pkgs.fetchFromGitHub {
    owner = "NvChad";
    repo = "starter";
    rev = "main";
    hash = "sha256-xdLr6tlU9uA+wu0pqha2br0fdVm+1MjgjbB5awz9ICU=";
  };
}