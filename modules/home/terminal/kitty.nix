# modules/home/terminal/kitty.nix
{ ... }:

{
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

    themeFile = "Catppuccin-Mocha";
  };
}