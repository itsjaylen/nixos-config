{ inputs, ... }:

{
  imports = [
    inputs.niri-session-manager.nixosModules.niri-session-manager
  ];

  services.niri-session-manager = {
    enable = true;
  };
}
