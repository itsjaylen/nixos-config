# modules/home/apps.nix
{ pkgs, inputs, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  # Add user-level packages here
  home.packages = with pkgs; [
    kdePackages.kdeconnect-kde
  ];

  # Git
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Jaylen";
      };
    };
  };

  # Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # OBS Studio
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
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