{ pkgs, ... }:

{
  programs.swaylock = {
    enable = true;

    # Uses swaylock-effects fork for background blurs & vignette filters
    package = pkgs.swaylock-effects;

    settings = {
      clock = true;
      daemonize = true;
      screenshots = true;
      ignore-empty-password = true;
      fade-in = 0.2;

      # Indicator layout
      indicator = true;
      indicator-radius = 111;
      indicator-thickness = 9;

      # Screen processing pipeline (Screenshot -> Pixelate -> Blur -> Vignette)
      effect-pixelate = 5;
      effect-blur = "7x5";
      effect-vignette = "0.5:0.5";

      # Typography
      font = "Maple Mono";
      font-size = 24;

      # Colors (Gruvbox Dark Palette)
      # Format: RRGGBBAA
      text-color = "FBF1C7FF";
      text-clear-color = "FBF1C7FF";
      text-ver-color = "FBF1C7FF";
      text-wrong-color = "FBF1C7FF";

      # Ring indicator states
      ring-color = "689D6AFF";         # Aqua / Idle
      ring-clear-color = "D65D0EFF";   # Orange / Clear
      ring-ver-color = "B8BB26FF";     # Green / Verifying
      ring-wrong-color = "CC241DFF";   # Red / Wrong key

      # Keypress highlights
      key-hl-color = "FABD2FFF";       # Yellow / Character typed
      bs-hl-color = "FB4934FF";        # Red / Backspace pressed

      # Inside circle fills (Gruvbox Dark bg with ~86% opacity)
      inside-color = "3C3836DD";
      inside-clear-color = "3C3836DD";
      inside-ver-color = "3C3836DD";
      inside-wrong-color = "3C3836DD";

      # Transparent borders & separators
      line-color = "FFFFFF00";
      line-clear-color = "FFFFFF00";
      line-ver-color = "FFFFFF00";
      line-wrong-color = "FFFFFF00";
      separator-color = "FFFFFF00";

      # Layout text
      layout-bg-color = "FFFFFF00";
      layout-text-color = "FBF1C7FF";
    };
  };
}