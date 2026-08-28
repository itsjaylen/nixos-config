''
  input {
      keyboard {
          xkb { }
          numlock
      }

      touchpad {
          tap
          natural-scroll
      }

      mouse { }
      trackpoint { }

      focus-follows-mouse max-scroll-amount="0%"
  }

  output "DP-2" {
      mode "2560x1440@164.998"
      scale 1.0
      transform "normal"
      position x=1920 y=0
  }

  output "DP-3" {
      mode "1920x1080@60.000"
      scale 1.0
      transform "normal"
      position x=0 y=360
  }

  output "DP-1" {
      mode "1920x1080@144.000"
      scale 1.0
      transform "normal"
      position x=4480 y=0
  }

  layout {
      gaps 16
      center-focused-column "never"

      preset-column-widths {
          proportion 0.33333
          proportion 0.5
          proportion 0.66667
      }

      default-column-width { proportion 0.5; }

      focus-ring {
          width 4
          active-color "#000000"
          inactive-color "#505050"
      }

      border {
          off
          width 4
          active-color "#ffc87f"
          inactive-color "#505050"
          urgent-color "#9b0000"
      }

      shadow {
          softness 30
          spread 5
          offset x=0 y=5
          color "#0007"
      }

      struts { }
  }

  hotkey-overlay { }
  prefer-no-csd
  screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"
  animations { }

  blur {
      passes 0
      noise 0.0
  }

  spawn-sh-at-startup "niri-session-manager"
  spawn-sh-at-startup "kdeconnectd"
  spawn-sh-at-startup "noctalia"
  spawn-at-startup "/run/current-system/sw/libexec/polkit-kde-authentication-agent-1"
  spawn-at-startup "gpu-screen-recorder" "-w" "DP-2" "-f" "60" "-r" "30" "-c" "mp4" "-a" "default_output" "-o" "~/Videos/Replays"
  spawn-at-startup "niri-session-manager"
  spawn-at-startup "piri" "daemon"
''
