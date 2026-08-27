{ pkgs, inputs, ... }:
let
  spicetifyPkgs =
    inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  programs.spicetify = {
    enable = true;
    theme = spicetifyPkgs.themes.defaultDynamic;
    colorScheme = "Dark-Base";

    enabledCustomApps = with spicetifyPkgs.apps; [
      marketplace
    ];

    enabledExtensions = with spicetifyPkgs.extensions; [
      adblock
      adblockify
      autoSkipVideo
      fullAppDisplay
      hidePodcasts
      history
      keyboardShortcut
      playNext
      queueTime
      seekSong
      showQueueDuration
      shuffle
      sideHide
      skipStats
      sleepTimer
      songStats
      trashbin
      volumePercentage
    ];
  };
}