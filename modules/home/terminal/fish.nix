# modules/home/terminal/fish.nix
{ pkgs, ... }:

{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set -U fish_color_command green

      # Disable the default fish welcome message
      set fish_greeting

      set -l seq_file ~/.cache/ags/user/generated/terminal/sequences.txt
      if test -f $seq_file
          cat $seq_file
      end

      set -gx PATH $PATH (go env GOPATH)/bin
      fish_add_path ~/.local/bin/

      # Abbreviations (expands automatically when you press space/enter)
      abbr -a g git
      abbr -a gst git status
      abbr -a gco git checkout
      abbr -a nr nh os switch
    '';

    shellAliases = {
      homeserver = "kitten ssh jaylen@192.168.50.232";
      homelabtop = "kitten ssh jaylen@192.168.50.32";
      homeserverb = "kitten ssh root@192.168.50.188";
      deployserver = "kitten ssh jaylen@192.168.50.192";
      icat = "kitten icat";
      cd = "z";

      ls = "eza --icons=always --color=always --group-directories-first";
      la = "eza --icons=always --color=always --group-directories-first -a";
      ll = "eza --icons=always --color=always --group-directories-first -lh";
      lt = "eza --icons=always --color=always --group-directories-first --tree";
      jsmem = "sudo smem -rs swap -n | python3 -c 'import sys, json; lines = [l.split() for l in sys.stdin.read().strip().split(\"\\n\")]; print(json.dumps([dict(zip(lines[0], row)) for row in lines[1:]]))'";
    };

    functions = {
      set_kitty_colors = ''
        set color_file ~/.cache/ags/user/generated/kitty-colors.conf
        if test -f $color_file
            kitty @ set-colors --all --configured $color_file
        else
            echo "Color scheme file not found: $color_file"
        end
      '';

      y = ''
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
      '';
    };

    plugins = [
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
          rev = "v10.3"; # Or the latest stable tag
          sha256 = "sha256-T8KYLA/r/gOKvAivKRoeqIwE2pINlxFQtZJHpOy9GMM=";
        };
      }
    ];
  };
}