{ ... }:

{
  programs.fish.functions = {
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
}