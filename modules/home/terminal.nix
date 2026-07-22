# modules/home/terminal.nix
{ pkgs, ... }:

{
  # Kitty
  programs.kitty = {
    enable = true;
    extraConfig = ''
      font_family Papyrus Nerd Font Mono
      font_size 16.0
      bold_font auto
      italic_font auto
      bold_italic_font auto
      spacing 0

      background_opacity 0.7
      confirm_os_window_close 0
      linux_display_server auto

      scrollback_lines 9000
      wheel_scroll_min_lines 1
      enable_audio_bell no
      window_padding_width 4

      selection_foreground none
      selection_background none
      foreground #dddddd
      background #000000
      cursor #dddddd

      map ctrl+shift+j launch ssh jaylen@192.168.50.232
      map f1 new_window_with_cwd
      map f2 close_window

      map super+v             paste_from_clipboard
      map ctrl+shift+s        paste_from_selection
      map super+c             copy_to_clipboard
      map shift+insert        paste_from_selection

      map ctrl+shift+up       scroll_line_up
      map ctrl+shift+down     scroll_line_down
      map ctrl+shift+k        scroll_line_up
      map ctrl+shift+page_up   scroll_page_up
      map ctrl+shift+page_down scroll_page_down
      map ctrl+shift+home     scroll_home
      map ctrl+shift+end      scroll_end
      map ctrl+shift+h        show_scrollback

      map super+n             new_os_window
      map super+w             close_window
      map ctrl+shift+enter    new_window
      map ctrl+shift+]        next_window
      map ctrl+shift+[        previous_window
      map ctrl+shift+f        move_window_forward
      map ctrl+shift+b        move_window_backward
      map ctrl+shift+`        move_window_to_top

      map ctrl+shift+right    next_tab
      map ctrl+shift+left     previous_tab
      map ctrl+shift+t        new_tab
      map ctrl+shift+q        close_tab
      map ctrl+shift+l        next_layout
      map ctrl+shift+.        move_tab_forward
      map ctrl+shift+,        move_tab_backward

      map ctrl+shift+backspace restore_font_size

      hide_window_decorations yes
      remember_window_size yes
      allow_remote_control yes

      include ./theme.conf
    '';
  };

  # Starship Prompt
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;

    settings = {
      add_newline = false;
      format = "$directory$git_branch$rust$python\n$character";
      palette = "colors";

      palettes.colors = {
        mustard = "#af8700";
        color1 = "#f8b1dc";
        color2 = "#501e41";
        color3 = "#d3c2c9";
        color4 = "#251e21";
        color5 = "#501e41";
        color6 = "#181115";
        color7 = "#181115";
        color8 = "#f8b1dc";
        color9 = "#f4ba9f";
      };

      character = {
        success_symbol = "[🞈](color9 bold)";
        error_symbol = "[🞈](color1 bold)";
        vicmd_symbol = "[🞈](#f9e2af)";
      };

      directory = {
        format = "[](fg:color1 bg:color4)[󰉋](bg:color1 fg:color2)[ ](fg:color1 bg:color4)[$path ](fg:color3 bg:color4)[ ](fg:color4)";
        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = " ";
          "Pictures" = " ";
        };
      };

      git_branch = {
        format = "[](fg:color8 bg:color4)[ ](bg:color8 fg:color5)[](fg:color8 bg:color4)[(bg:color8 fg:color5) $branch](fg:color3 bg:color4)[](fg:color4) ";
      };

      time = {
        format = "[](fg:color8 bg:color4)[ ](bg:color8 fg:color5)[](fg:color8 bg:color4)[(bg:color8 fg:color5) $time](fg:color3 bg:color4)[](fg:color4) ";
        disabled = false;
        time_format = "%R";
      };

      python = {
        format = "[](fg:color8 bg:color4)[$symbol$version](bg:color8 fg:color5)[](fg:color8 bg:color4)[(bg:color8 fg:color5)( $virtualenv)](fg:color3 bg:color4)[](fg:color4) ";
        symbol = "🐍";
        pyenv_prefix = "venv";
      };

      nix_shell = {
        symbol = "❄️ ";
      };
    };
  };

  # SSH
# modules/home/terminal.nix
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
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

  # Config Files
  xdg.configFile = {
    "kitty/theme.conf".text = ''
      foreground              #CDD6F4
      background              #1E1E2E
      selection_foreground    #1E1E2E
      selection_background    #F5E0DC
      cursor                  #F5E0DC
      cursor_text_color       #1E1E2E
      url_color               #B4BEFE
      active_border_color     #CBA6F7
      inactive_border_color   #8E95B3
      bell_border_color       #EBA0AC
      wayland_titlebar_color system
      macos_titlebar_color system
      active_tab_foreground   #11111B
      active_tab_background   #CBA6F7
      inactive_tab_foreground #CDD6F4
      inactive_tab_background #181825
      tab_bar_background      #11111B
      mark1_foreground #1E1E2E
      mark1_background #87B0F9
      mark2_foreground #1E1E2E
      mark2_background #CBA6F7
      mark3_foreground #1E1E2E
      mark3_background #74C7EC
      color0 #43465A
      color8 #43465A
      color1 #F38BA8
      color9 #F38BA8
      color2  #A6E3A1
      color10 #A6E3A1
      color3  #F9E2AF
      color11 #F9E2AF
      color4  #87B0F9
      color12 #87B0F9
      color5  #F5C2E7
      color13 #F5C2E7
      color6  #94E2D5
      color14 #94E2D5
      color7  #CDD6F4
      color15 #A1A8C9
    '';

    "kitty/ssh.conf".text = ''
      hostname *
      remote_dir .local/share/kitty-ssh-kitten
      shell_integration inherited
      share_connections yes
      copy --dest .config/fish .config/fish
    '';
  };
}