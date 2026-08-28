{ ... }:
{
  imports = [
    ./bat.nix # better cat command
    ./browser.nix # firefox based browser
    ./btop.nix # resources monitor
    ./chatterino.nix # chatterino
    ./direnv.nix
    ./discord.nix # discord
    ./fastfetch/fastfetch.nix # fetch tool
    ./fish # shell
    ./fzf.nix # fuzzy finder
    ./gaming.nix # packages related to gaming
    ./git.nix # version control
    ./gtk.nix # gtk theme
    ./kde.nix # kde apps
    ./kitty.nix # terminal
    ./lazygit.nix
    ./niri # window manager
    ./noctalia/noctalia.nix # desktop components & notifications
    ./nvim.nix # neovim editor
    ./packages # other packages
    ./spicetify.nix # spotify client
    ./ssh.nix # ssh config
    ./starship.nix # starship prompt
    ./superfile/superfile.nix # terminal file manager
    ./swaylock.nix # lock screen
    ./swaync/swaync.nix # notification daemon
    ./xdg-mines.nix # xdg config
    ./zoxide.nix # zoxide
  ];
}
