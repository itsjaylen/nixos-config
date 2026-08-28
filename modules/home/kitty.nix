{ host, ... }:

{
  programs.kitty = {
    enable = true;

    # Theme stays Gruvbox Dark Hard from the new config
    themeFile = "gruvbox-dark-hard";

    font = {
      name = "Maple Mono";
      size = if (host == "laptop") then 15 else 16;
    };

    # Retain Maple Mono ligatures & stylistic sets (+ss01 +ss02 +ss04)
    extraConfig = ''
      font_features MapleMono-Regular +ss01 +ss02 +ss04
      font_features MapleMono-Bold +ss01 +ss02 +ss04
      font_features MapleMono-Italic +ss01 +ss02 +ss04
      font_features MapleMono-Light +ss01 +ss02 +ss04
    '';

    settings = {
      # Font & Window Base
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      confirm_os_window_close = 0;
      background_opacity = "0.66"; # New config's opacity
      scrollback_lines = 10000;
      enable_audio_bell = false;
      mouse_hide_wait = 60;
      window_padding_width = if (host == "laptop") then 5 else 10;
      hide_window_decorations = "yes";
      remember_window_size = "yes";
      allow_remote_control = "yes";
      wheel_scroll_min_lines = 1;
      linux_display_server = "auto";

      ## Tabs (New Config Gruvbox Powerline Styling)
      tab_title_template = "{index}";
      active_tab_font_style = "normal";
      inactive_tab_font_style = "normal";
      tab_bar_style = "powerline";
      tab_powerline_style = "angled";
      active_tab_foreground = "#FBF1C7";
      active_tab_background = "#7C6F64";
      inactive_tab_foreground = "#FBF1C7";
      inactive_tab_background = "#3C3836";
    };

    keybindings = {
      ## Fast Tab Navigation (New Config Base)
      "alt+1" = "goto_tab 1";
      "alt+2" = "goto_tab 2";
      "alt+3" = "goto_tab 3";
      "alt+4" = "goto_tab 4";

      ## Window Management (New Config Base)
      "f1" = "new_window_with_cwd";
      "f2" = "close_window";

      ## Quick SSH Shortcut (From Old Config)
      "ctrl+shift+j" = "launch ssh jaylen@192.168.50.232";

      ## Clipboard Controls (From Old Config)
      "super+v" = "paste_from_clipboard";
      "super+c" = "copy_to_clipboard";
      "ctrl+shift+s" = "paste_from_selection";
      "shift+insert" = "paste_from_selection";

      ## Scrollback Navigation (From Old Config)
      "ctrl+shift+up" = "scroll_line_up";
      "ctrl+shift+down" = "scroll_line_down";
      "ctrl+shift+k" = "scroll_line_up";
      "ctrl+shift+page_up" = "scroll_page_up";
      "ctrl+shift+page_down" = "scroll_page_down";
      "ctrl+shift+home" = "scroll_home";
      "ctrl+shift+end" = "scroll_end";
      "ctrl+shift+h" = "show_scrollback";

      ## Windows & Layout Management (From Old Config)
      "super+n" = "new_os_window";
      "super+w" = "close_window";
      "ctrl+shift+enter" = "new_window";
      "ctrl+shift+]" = "next_window";
      "ctrl+shift+[" = "previous_window";
      "ctrl+shift+f" = "move_window_forward";
      "ctrl+shift+b" = "move_window_backward";
      "ctrl+shift+`" = "move_window_to_top";

      ## Extended Tab Controls (From Old Config)
      "ctrl+shift+right" = "next_tab";
      "ctrl+shift+left" = "previous_tab";
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+q" = "close_tab";
      "ctrl+shift+l" = "next_layout";
      "ctrl+shift+." = "move_tab_forward";
      "ctrl+shift+," = "move_tab_backward";

      ## Utility
      "ctrl+shift+backspace" = "restore_font_size";
    };
  };
}
