{ ... }:
{
  programs.btop = {
    enable = true;

    settings = {
      color_theme = "TTY";
      theme_background = false;
      update_ms = 100;
      rounded_corners = false;
    };
  };
}
