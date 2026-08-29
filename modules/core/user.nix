{
  pkgs,
  inputs,
  username,
  host,
  lib,
  ...
}:
{
  imports = lib.optionals (host != "server") [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = lib.mkIf (host != "server") {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs username host; };

    backupFileExtension = "hm-backup";

    users.${username} = {
      imports = [ ./../home ];
      home.username = "${username}";
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "26.05";
      programs.home-manager.enable = true;
    };
  };

  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
  };

  # Required so NixOS registers fish as a valid login shell
  programs.fish.enable = true;

  nix.settings.allowed-users = [ "${username}" ];
}