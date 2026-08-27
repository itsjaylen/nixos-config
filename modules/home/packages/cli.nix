{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ## Better core utils
    duf                               # disk information
    eza                               # ls replacement
    fd                                # find replacement
    gping                             # ping with a graph
    gtrash                            # rm replacement, put deleted files in system trash
    hexyl                             # hex viewer
    man-pages                         # extra man pages
    ncdu                              # disk space
    ripgrep                           # grep replacement
    tldr
    tree
    zoxide

    ## Tools / useful cli
    binsider
    bitwise                           # cli tool for bit / hex manipulation
    caligula                          # User-friendly, lightweight TUI for disk imaging
    hyperfine                         # benchmarking tool
    just                              # command runner (makefile like)
    pastel                            # cli to manipulate colors
    scooter                           # Interactive find and replace in the terminal
    swappy                            # snapshot editing tool
    tokei                             # project line counter
    translate-shell                   # cli translator
    woomer
    yt-dlp-light
    mdcat
    p7zip

    ## TUI
    epy                               # ebook reader
    gtt                               # google translate TUI

    ## Monitoring / fetch
    htop
    onefetch                          # fetch utility for git repo

    ## Multimedia
    imv
    lowfi
    mpv

    ## Utilities
    entr                              # perform action when file change
    ffmpeg
    file                              # Show file information
    jq                                # JSON processor
    killall
    libnotify
    mimeo
    openssl
    playerctl                         # controller for media players
    poweralertd
    socat
    udiskie                           # Automounter for removable media
    unzip
    wget
    curl
    wl-clipboard                      # clipboard utils for wayland (wl-copy, wl-paste)
    vscode
    xdg-utils

    winetricks
    wineWow64Packages.waylandFull
  ];
}