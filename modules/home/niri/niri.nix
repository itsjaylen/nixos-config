{ pkgs, ... }:

{
  home.packages = with pkgs; [
    awww                # Wallpaper daemon
    grimblast           # Smart screenshot wrapper
    grim                # Wayland screenshot utility
    slurp               # Screen region selector
    wl-clip-persist     # Keep clipboard contents after app closure
    cliphist            # Clipboard manager
    glib
    wayland
    direnv
  ];

  # Niri compositor module configuration
  programs.niri = {
    enable = true;

    package = pkgs.niri;

    settings = {
      xwayland = {
        enable = true;
      };

      spawn-at-startup = [
        { command = [ "${pkgs.wl-clip-persist}/bin/wl-clip-persist" "--clipboard" "regular" ]; }
        { command = [ "${pkgs.cliphist}/bin/cliphist" "wipe" ]; }
      ];

      environment = {
        NIXOS_OZONE_WL = "1";
        DISPLAY = ":0";
      };
    };
  };

  systemd.user.targets.niri-session = {
    Unit = {
      Description = "Niri Wayland Compositor Session";
      Documentation = [ "man:systemd.special(7)" ];
      BindsTo = [ "graphical-session.target" ];
      Wants = [ "graphical-session-pre.target" "xdg-desktop-autostart.target" ];
      After = [ "graphical-session-pre.target" ];
    };
  };
}