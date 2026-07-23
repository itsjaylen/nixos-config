{ pkgs, ... }:

{
  # Kitty Configuration (Native attributes instead of raw text)
  programs.kitty = {
    enable = true;
    font = {
      name = "Papyrus Nerd Font Mono";
      size = 16.0;
    };
    settings = {
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      spacing = 0;

      background_opacity = "0.7";
      confirm_os_window_close = 0;
      linux_display_server = "auto";

      scrollback_lines = 9000;
      wheel_scroll_min_lines = 1;
      enable_audio_bell = "no";
      window_padding_width = 4;

      selection_foreground = "none";
      selection_background = "none";
      foreground = "#dddddd";
      background = "#000000";
      cursor = "#dddddd";

      hide_window_decorations = "yes";
      remember_window_size = "yes";
      allow_remote_control = "yes";
    };

    # Keymaps mapped cleanly via settings
    keybindings = {
      "ctrl+shift+j" = "launch ssh jaylen@192.168.50.232";
      "f1" = "new_window_with_cwd";
      "f2" = "close_window";
      "super+v" = "paste_from_clipboard";
      "ctrl+shift+s" = "paste_from_selection";
      "super+c" = "copy_to_clipboard";
      "shift+insert" = "paste_from_selection";
      "ctrl+shift+up" = "scroll_line_up";
      "ctrl+shift+down" = "scroll_line_down";
      "ctrl+shift+k" = "scroll_line_up";
      "ctrl+shift+page_up" = "scroll_page_up";
      "ctrl+shift+page_down" = "scroll_page_down";
      "ctrl+shift+home" = "scroll_home";
      "ctrl+shift+end" = "scroll_end";
      "ctrl+shift+h" = "show_scrollback";
      "super+n" = "new_os_window";
      "super+w" = "close_window";
      "ctrl+shift+enter" = "new_window";
      "ctrl+shift+]" = "next_window";
      "ctrl+shift+[" = "previous_window";
      "ctrl+shift+f" = "move_window_forward";
      "ctrl+shift+b" = "move_window_backward";
      "ctrl+shift+`" = "move_window_to_top";
      "ctrl+shift+right" = "next_tab";
      "ctrl+shift+left" = "previous_tab";
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+q" = "close_tab";
      "ctrl+shift+l" = "next_layout";
      "ctrl+shift+." = "move_tab_forward";
      "ctrl+shift+," = "move_tab_backward";
      "ctrl+shift+backspace" = "restore_font_size";
    };

    themeFile = "Catppuccin-Mocha"; # Or point directly to your theme file cleanly
  };

  # Fish Shell Configuration
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting

      set -l seq_file ~/.cache/ags/user/generated/terminal/sequences.txt
      if test -f $seq_file
          cat $seq_file
      end

      set -gx PATH $PATH (go env GOPATH)/bin
      fish_add_path ~/.local/bin/
    '';

    shellAliases = {
      pamcan = "pacman";
      bar = "nvim ~/.config/ags/modules/bar/main.js";
      barmodes = "nvim ~/.config/ags/modules/bar/modes";
      config = "yazi ~/.dotfiles";
      colors = "kitty @ set-colors -a -c ~/.cache/ags/user/generated/kitty-colors.conf";
      homeserver = "kitten ssh jaylen@192.168.50.232";
      homelabtop = "kitten ssh jaylen@192.168.50.32";
      homeserverb = "kitten ssh root@192.168.50.188";
      deployserver = "kitten ssh jaylen@192.168.50.192";
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
    ];
  };

  # Zoxide integration
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  # Starship Prompt (kept clean)
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = false;
      format = "$directory$git_branch$rust$python\n$character";
    };
  };

  # Native SSH Configuration (Replaces raw file blocks)
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        addKeysToAgent = "yes";
      };
      "homelab" = {
        hostname = "192.168.50.232";
        user = "jaylen";
        identityFile = "~/.ssh/id_ed25519";
      };
      "pve" = {
        hostname = "192.168.50.215";
        user = "root";
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    CHROMIUM_FLAGS = "--disable-gpu-compositing";
    NVM_DIR = "$HOME/.nvm";
  };
}