{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ## Lsp
    nixd # nix

    ## formating
    shfmt
    treefmt
    nixfmt

    ## C / C++
    gcc
    gdb
    gef
    go
    cmake
    gnumake
    valgrind
    llvmPackages_20.clang-tools

    ## Python
    python3
    python312Packages.ipython
  ];
}