# modules/home/apps.nix
{ pkgs, inputs, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  imports = [
    # Import Zen Home Manager module from flake inputs
    inputs.zen-browser.homeModules.beta
  ];

  # Add user-level packages here
  home.packages = with pkgs; [
    kdePackages.kdeconnect-kde
    zed-editor
  ];

  # Zen Browser Configuration
  programs.zen-browser = {
    enable = true;
  };

  # Git
  programs.git = {
    enable = true;
    userName = "itsjaylen";
    userEmail = "bossjaylen145@gmail.com";
    extraConfig = {
      credential.helper = "store";
      # Or use "cache --timeout=3600" if you want it to forget after 1 hour
    };
  };

  # Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # OBS Studio (with full CUDA/NVENC support via pkgs.pkgsCuda)
  programs.obs-studio = {
    enable = true;
    package = pkgs.pkgsCuda.obs-studio;
    plugins = with pkgs.pkgsCuda.obs-studio-plugins; [
      wlrobs
      obs-vkcapture
      obs-pipewire-audio-capture
    ];
  };

  # Spicetify Configuration
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.defaultDynamic;
    colorScheme = "Dark-Base";

    enabledExtensions = with spicePkgs.extensions; [
      shuffle
      fullAppDisplay
      keyboardShortcut
      QueueTime
      SleepTimer
      adblock
      adblockify
      history
      showQueueDuration
      skipStats
      trashbin
      volumePercentage
      autoSkipVideo
      songStats
      sideHide
    ];

    enabledCustomApps = with spicePkgs.apps; [
      marketplace
    ];
  };
}