{ pkgs, ... }:

{
  programs.fish.plugins = [
    {
      name = "nvm";
      src = pkgs.fetchFromGitHub {
        owner = "jorgebucaran";
        repo = "nvm.fish";
        rev = "2.2.1";
        hash = "sha256-ZZpDdJJ3yH4ZgsoEQ7O/A0E1DUO10rSx6dlebPQWotE=";
      };
    }
    {
      name = "fzf.fish";
      src = pkgs.fetchFromGitHub {
        owner = "PatrickF1";
        repo = "fzf.fish";
        rev = "v10.3";
        sha256 = "sha256-T8KYLA/r/gOKvAivKRoeqIwE2pINlxFQtZJHpOy9GMM=";
      };
    }
  ];
}
