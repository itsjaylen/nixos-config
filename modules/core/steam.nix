{
  pkgs,
  inputs,
  username,
  ...
}:
{
  nixpkgs.overlays = [
    inputs.millennium.overlays.default
  ];

  programs = {
    steam = {
      enable = true;

      package = pkgs.millennium-steam;

      gamescopeSession.enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };

    gamescope = {
      enable = true;
      capSysNice = true;
      args = [
        "--rt"
        "--expose-wayland"
      ];
    };

    gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          softrealtime = "auto";
          renice = 10;
        };
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode' 'Started'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode' 'Ended'";
        };
      };
    };
  };

  users.users.${username}.extraGroups = [ "gamemode" ];

  hardware.steam-hardware.enable = true;
}
