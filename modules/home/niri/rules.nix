{ config, pkgs, ... }:

{
  xdg.configFile."niri/config.kdl".text = config.xdg.configFile."niri/config.kdl".text + ''
    // WezTerm Initial Configure Workaround
    window-rule {
        match app-id=r"^org\.wezfurlong\.wezterm$"
        default-column-width {}
    }

    // Floating Firefox Picture-in-Picture
    window-rule {
        match app-id=r"firefox$" title="^Picture-in-Picture$"
        open-floating true
    }

    // Global Window Rules
    window-rule {
        opacity 0.9
        background-effect {
            blur true
            xray false
        }
    }
  '';
}