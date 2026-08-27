{ pkgs, ... }:

{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      # Added quotes around "green" so Fish sets the actual color string
      set -U fish_color_command "green"

      # Disable the default fish welcome message
      set fish_greeting

      set -l seq_file ~/.cache/ags/user/generated/terminal/sequences.txt
      if test -f $seq_file
          cat $seq_file
      end

      set -gx PATH $PATH (go env GOPATH)/bin
      fish_add_path ~/.local/bin/
    '';
  };
}